## Pasos para ejecutar el docker en Terminal

1. Ir a la carpeta Docker
```
cd Docker
```
2. Crear docker
```
docker build -t sienapa-web:v1 .
```
3. Ingresar a la carpeta web
```
cd ..
cd web
```
4. Crear volumen de Docker
```
docker volume create webapp
```
5. Crear entorno en el contenedor
```
docker container run -d -it -v "$PWD":/home/web --net=host --name sienapa-web -h SIENAPA --mount source=webapp,target=/app sienapa-web:v1
```
6. Ejecutar la imagen
```
docker start -i sienapa-web
```
7. Ejecutar el archivo de Python
```
cd /home/web
python3 app.py
```
8. Para salir **Ctrl + C** >> Escribir **exit y presionar enter** 