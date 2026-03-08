# Guía Completa para Bloquear Autopilot, MDM y Azure

## Advertencia Previa: Sobre la persistencia de Autopilot

Antes de empezar, es crucial entender que estos pasos por software evaden el bloqueo de forma muy robusta, pero no son permanentes ni infalibles. El sistema Autopilot de Microsoft asocia el equipo a la empresa mediante un identificador físico (Hardware Hash). Si el equipo se formatea o se restablece de fábrica en el futuro sin aplicar de nuevo esta guía, volverá a bloquearse.

Las únicas formas definitivas e infalibles de desvincular el equipo para siempre son:

- **Modificar el Número de Serie / UUID en la BIOS**: Alterar el "ADN" del hardware para que cambie el Hardware Hash. Esto requiere herramientas de ingeniería muy específicas del fabricante (DMI Tools) y puede ser complicado y arriesgado. Siempre es recomendable investigar en foros técnicos si existe un método o software filtrado para tu modelo exacto.

- **Cambiar la placa base entera**: Esto genera un hardware nuevo, pero suele ser económicamente inviable.

Asumiendo que procedemos por la vía del software, esta es la guía definitiva.

## Fase 1: Limpieza profunda de hardware (BIOS/UEFI)

Antes de instalar Windows, debemos destruir cualquier rastro criptográfico o software de rastreo anclado en la placa base de la antigua empresa.

1. Enciende el equipo e ingresa a la BIOS/UEFI (normalmente presionando F2, F10, F12, Del o Esc repetidamente al arrancar).

2. **Limpiar el módulo TPM**: Busca la pestaña de Security (Seguridad). Localiza la opción referente al chip TPM (puede llamarse TPM Security, Security Chip o Intel PTT/AMD fTPM). Selecciona la opción Clear TPM (Borrar TPM) o Reset to Factory. Esto eliminará cualquier certificado o clave corporativa guardada físicamente en el chip.

3. **Desactivar el Absolute Persistence Module (Computrace)**: En esa misma pestaña de Seguridad, busca si el equipo cuenta con opciones llamadas Absolute Persistence, Computrace o Lojack. Si lo tiene, cambia su estado a Permanently Disable (Desactivar permanentemente). Guarda los cambios y sal de la BIOS.

## Fase 2: Preparación del USB (Forzar Windows 11 Home)

Nota: Instalar la versión Windows 11 Home es opcional pero altamente recomendado. La versión Home carece de los componentes internos necesarios para unirse a un dominio de Azure o ejecutar Autopilot. Al forzar esta versión, añadimos una barrera estructural contra la antigua empresa.

Como los portátiles corporativos llevan la licencia Pro grabada en la placa base, el instalador la leerá automáticamente. Para evitarlo:

1. Crea un USB con la imagen oficial de Windows 11 usando la herramienta de Microsoft.

2. Conecta el USB en tu equipo actual y abre la carpeta llamada sources.

3. Haz clic derecho en un espacio vacío > Nuevo > Documento de texto.

4. Pega exactamente las siguientes líneas:

   ```
   [EditionID]
   Core
   [Channel]
   Retail
   [VL]
   0
   ```

5. Selecciona Archivo > Guardar como. En la opción "Tipo", elige Todos los archivos (.). Nombra el archivo exactamente como ei.cfg y guárdalo.

## Fase 3: Instalación Limpia y Salto de Red (BypassNRO)

1. Desconecta el portátil físicamente de internet (sin cable Ethernet y, si es necesario, apaga tu router Wi-Fi temporalmente).

2. Arranca el equipo desde el USB e inicia la instalación.

3. Al llegar a la pantalla "¿Dónde quieres instalar Windows?", selecciona una por una todas las particiones existentes y pulsa Eliminar hasta que el disco entero sea "Espacio sin asignar". Selecciona ese espacio y pulsa Siguiente.

4. Cuando termine de instalar y aparezca la primera pantalla de configuración ("¿Es este el país o región correcto?"), presiona las teclas Shift + F10 (o Shift + Fn + F10) para abrir la consola de comandos (CMD).

5. Escribe exactamente `oobe\bypassnro` y presiona Enter.

6. El equipo se reiniciará. Vuelve a seleccionar el país y teclado. Al llegar a la pantalla de red, aparecerá una nueva opción abajo: "No tengo internet". Púlsala.

7. Selecciona "Continuar con la configuración limitada", crea una cuenta de usuario Local (ej. "Admin") y termina hasta llegar al escritorio.

## Fase 4: Purgado de Claves y Candado de la Versión

Aplica estos pasos en el escritorio, manteniendo el equipo sin internet, para evitar que Windows recupere su versión Pro original.

1. Abre el menú Inicio, escribe cmd, haz clic derecho en "Símbolo del sistema" y selecciona Ejecutar como administrador.

2. Borra la clave de la placa base del registro ejecutando: `slmgr.vbs /cpky`

3. Desinstala cualquier clave precargada ejecutando: `slmgr.vbs /upk`

4. Fija la versión Home con la clave genérica oficial ejecutando: `slmgr.vbs /ipk YTMG3-N6DKC-DKB77-7M9GH-8HVX7`

5. Bloquea las actualizaciones de versión forzadas: Presiona Windows + R, escribe regedit y navega hasta `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft`. Si no existe, crea dentro una clave llamada WindowsStore. Dentro de ella, crea un "Valor de DWORD (32 bits)" llamado DisableOSUpgrade y ponle valor 1.

## Fase 5: Desactivación de Telemetría y Módulos MDM

Cortaremos de raíz los servicios de Windows encargados de la administración remota.

En el mismo cmd como Administrador, ejecuta estos dos comandos para inutilizar el motor de enrutamiento MDM:

```
sc stop dmwappushservice
sc config dmwappushservice start= disabled
```

Ejecuta estos dos para apagar la telemetría corporativa:

```
sc stop DiagTrack
sc config DiagTrack start= disabled
```

Ejecuta este comando en una sola línea para prohibir la inscripción de dispositivos móviles:

```
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\MDM" /v DisableRegistration /t REG_DWORD /d 1 /f
```

Ejecuta este comando para bloquear la unión automática a Azure (Entra ID) en segundo plano:

```
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WorkplaceJoin" /v BlockAADWorkplaceJoin /t REG_DWORD /d 1 /f
```

## Fase 6: Bloqueo de Servidores en el Archivo Hosts

Evitaremos que el equipo contacte con los dominios de despliegue de Microsoft, blindando el archivo para que el antivirus no lo revierta.

1. Abre el menú Inicio, busca el Bloc de notas y ábrelo como Administrador.

2. Ve a Archivo > Abrir. Navega a `C:\Windows\System32\drivers\etc`. Cambia la vista inferior a "Todos los archivos (.)" y abre el archivo hosts.

3. Añade estas dos líneas al final del texto, guarda (Ctrl+G) y cierra el bloc de notas:

   ```
   0.0.0.0 ztd.desktop.microsoft.com
   0.0.0.0 cs.dds.microsoft.com
   ```

4. Abre Seguridad de Windows > Protección antivirus y contra amenazas > Administrar la configuración. Baja hasta "Exclusiones", haz clic en Agregar o quitar exclusiones > Agregar exclusión > Archivo. Selecciona el archivo hosts que acabas de modificar.

5. Abre el Explorador de archivos, ve a `C:\Windows\System32\drivers\etc`, haz clic derecho sobre el archivo hosts > Propiedades, marca la casilla Solo lectura y dale a Aceptar.

## Fase 7: Conexión Final y Uso Seguro

Tu equipo ya está fortificado.

1. Conecta el equipo a Internet.

2. Ve a Configuración > Cuentas > Tu información y pulsa "Iniciar sesión con una cuenta de Microsoft en su lugar". Puedes añadir tu cuenta personal libremente. Configura Windows Hello (PIN o Biometría) en "Opciones de inicio de sesión".

**Regla Crítica de Uso**: Si en algún momento necesitas iniciar sesión con una cuenta de trabajo (Office 365, Teams, Outlook), aparecerá una ventana diciendo "Permitir que mi organización administre mi dispositivo". Debes desmarcar siempre esa casilla y hacer clic explícitamente en "No, iniciar sesión solo en esta aplicación".

Siguiendo esta guía completa, el equipo actuará a todos los efectos como un ordenador personal de consumo, manteniendo bloqueadas las puertas traseras del control empresarial.
