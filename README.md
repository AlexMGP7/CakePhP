```markdown
# Proyecto CakePHP con Docker

Este proyecto es una aplicación CakePHP que se ejecuta en contenedores Docker, lo que facilita la configuración y el despliegue. A continuación, se detallan los pasos para descargar el proyecto, iniciar los servicios, y cómo interactuar con el contenedor.

## Requisitos previos

Antes de comenzar, asegúrate de tener instalados los siguientes programas en tu máquina:

- [Git](https://git-scm.com/)
- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)

## 1. Clonar el repositorio

Para descargar el proyecto, clona este repositorio desde GitHub:

```bash
git clone https://github.com/AlexMGP7/CakePhP.git
```

```bash
cd CakePhP
```

## 2. Iniciar el proyecto con Docker

### Construir y levantar los contenedores

Para iniciar los contenedores y levantar la aplicación, utiliza el siguiente comando:

```bash
docker-compose up --build
```

Este comando construirá las imágenes Docker (si es necesario) y levantará los contenedores para la aplicación y la base de datos MySQL.

### Detener los contenedores

Si necesitas detener los contenedores en ejecución, puedes hacerlo con el siguiente comando:

```bash
docker-compose down
```

Esto detendrá y eliminará los contenedores, pero **no eliminará los volúmenes de la base de datos**.

### Reiniciar los contenedores

Si ya has construido los contenedores anteriormente y solo necesitas reiniciarlos, usa:

```bash
docker-compose up
```

## 3. Acceder al contenedor de la aplicación

Si necesitas acceder al contenedor donde corre la aplicación CakePHP para ejecutar comandos de Composer o CakePHP, usa el siguiente comando:

```bash
docker exec -it cakephp-app bash
```

Este comando te llevará a la terminal dentro del contenedor.

### Para salir del contenedor:

Para salir del contenedor y regresar a tu terminal local, simplemente escribe:

```bash
exit
```

## 4. Acceder a la base de datos MySQL

Puedes acceder a la base de datos MySQL desde el contenedor de la aplicación:

1. Accede al contenedor de la aplicación:

    ```bash
    docker exec -it cakephp-app bash
    ```

2. Luego, conecta a la base de datos MySQL desde el contenedor:

    ```bash
    mysql -h db -u user -p
    ```

El host es `db` (el nombre del servicio definido en `docker-compose.yml`), el usuario es `user`, y la contraseña es `password`.

## 5. Acceder a phpMyAdmin (Opcional)

Si has configurado **phpMyAdmin** en Docker, puedes acceder a la interfaz web de administración de MySQL en:

[http://localhost:8081](http://localhost:8081)

Las credenciales de acceso son las mismas que las configuradas en el archivo `docker-compose.yml`:

- **Usuario**: `user`
- **Contraseña**: `password`

## 6. Configuración de la base de datos en CakePHP

La configuración de la base de datos para CakePHP está en el archivo `config/app_local.php`. El host de la base de datos debe ser `db`, y las credenciales deben coincidir con las configuradas en `docker-compose.yml`.

Aquí un ejemplo de cómo debería verse la configuración:

```php
'Datasources' => [
    'default' => [
        'className' => Connection::class,
        'driver' => Mysql::class,
        'persistent' => false,
        'host' => 'db',
        'username' => 'user',
        'password' => 'password',
        'database' => 'cakephp_db',
        'encoding' => 'utf8mb4',
        'timezone' => 'UTC',
        'cacheMetadata' => true,
        'quoteIdentifiers' => false,
        'log' => false,
        'url' => env('DATABASE_URL', null),
    ],
],
```

## 7. Ejecutar migraciones de la base de datos

Si necesitas ejecutar las migraciones de la base de datos, asegúrate de que los contenedores estén corriendo y ejecuta el siguiente comando dentro del contenedor de la aplicación:

```bash
bin/cake migrations migrate
```

Esto aplicará cualquier migración pendiente en la base de datos.

## 8. Composer

El manejo de dependencias se realiza con **Composer**. Si necesitas instalar o actualizar dependencias dentro del contenedor de la aplicación, puedes usar el siguiente comando:

```bash
docker exec -it cakephp-app composer install
```

Este comando instalará las dependencias del proyecto según el archivo `composer.json`.

## 9. Estructura del proyecto

La estructura del proyecto es la siguiente:

```
/proyecto-cakephp
├── bin/                     # Ejecutables y utilidades
├── config/                  # Archivos de configuración del proyecto
├── logs/                    # Archivos de logs generados
├── src/                     # Código fuente de la aplicación CakePHP
├── templates/               # Plantillas de vistas de CakePHP
├── tests/                   # Pruebas unitarias y funcionales
├── vendor/                  # Dependencias instaladas por Composer
├── docker-compose.yml        # Configuración de Docker Compose
├── Dockerfile               # Dockerfile para la construcción del contenedor
└── README.md                # Instrucciones del proyecto
```

## 10. Información adicional

### Puerto de la aplicación

La aplicación CakePHP estará disponible en el navegador en [http://localhost:8080](http://localhost:8080) una vez que los contenedores estén en ejecución.

---

Si tienes alguna duda o problema al seguir estos pasos, revisa que Docker esté correctamente instalado y que los contenedores estén corriendo con `docker ps`.

¡Gracias por usar este proyecto!