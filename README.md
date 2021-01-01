# Robot Manipulador de 4 Grados de Libertad

![alt text](https://github.com/ulidavfl/Proyecto-Fundamentos/blob/main/Modelo/Renders/Render.jpg?raw=true)

El objetivo de este proyecto es modelar un brazo robótico de 4 grados de libertad a través del método Denavit-Hartenberg para determinar la cinemática directa del mecanismo. Dentro de este repositorio se encuentran los archivos necesarios para el software de control basado en MATLAB interconectado con la plataforma Arduino.

## Software de Control: MATLAB

Los archivos de MATLAB consisten en un programa principal y una función los cuales son empleados para realizar el cálculo de la matriz de Denavit-Hartenberg a partir de los parámetros del manipulador.

## Modelo: Dorna Robot

El modelo físico del brazo robótico está basado en un robot de gama baja de la marca Dorna Robotics. A continuación, se encuentra una liga donde se puede observar los detalles del modelo:

[Dorna](https://dorna.ai/robot/dorna-2/)

## Interfaz de Control

Para controlar el robot se usará como plataforma base la placa de desarrollo Arduino. En este repositorio se encuentra el código necesario para programar el microcontrolador.
