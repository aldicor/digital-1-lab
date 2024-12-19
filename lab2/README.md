# Lab02 - Medidor de carga

# Integrantes


# Informe

Indice:

1. [Diseño implementado](#diseño-implementado)
2. [Simulaciones](#simulaciones)
3. [Implementación](#implementación)
4. [Preguntas](#preguntas)
5. [Conclusiones](#conclusiones)
6. [Referencias](#referencias)

## Diseño implementado

### Descripción

#### Detector de alarmas de baterias 

Para cumplir con los requerimientos solicitados en la guía, se empezó con el problema más sencillo. En este caso, para implementar una señal de alerta en caso de un estado de descarga por cada bateria, se puede notar que al realizar un análisis de tabla de verdad, el único caso en el que el sistema va a activar su alarma es cuando los 4 bits esten en estado bajo. 

|A_3 | A_2| A_1| A_0| Alarma|
| ----| ---- | -----| -----| ----|
|1| x|x|x| 0|
|x| 1|x|x| 0|
|x| x|1|x| 0|
|x| x|x|1| 0|
|0| 0|0|0| 1|

Por lo que la ecuación booleana que describiría el comportamiento de la alarma de una batería sería:
$$Alarma = \bar{A_3} \bar{A_2} \bar{A_1} \bar{A_0} $$

En cuanto al circuito, este podría ser implementado con dos compuertas *and* que niegen las entradas, y otra compuerta *and* que tenga como entradas las salidas de las dos compuertas.

En el caso de verilog, en el archivo de [descarga](descarga.v), se puede apreciar que primero se realizó un modulo para una batería que tuviera en cuenta una entrada de 4 bits (la carga de la batería) y una salida de 1 bit como la señal de alarma. Esta señal de alarma está representada por la función booleana mostrada con el uso de primitivas. En el mismo archivo se presenta un modelo donde se instancia el modulo de la alerta de batería 2 veces para hacerlo escalable, de esta manera se tienen 2 entradas de 4 bits que representan la carga de cada bateria y dos señales de descarga (que se encuentran en el mismo archivo). 

### Diagramas


## Simulaciones 

<!-- (Incluir las de Digital si hicieron uso de esta herramienta, pero también deben incluir simulaciones realizadas usando un simulador HDL como por ejemplo Icarus Verilog + GTKwave) -->




### Simulación del bloque de alarma de descarga
Tal y como se explicó anteriormente, el segundo módulo de descarga resive dos buses de entradas de 4 bits (cada bus representa el nivel de carga de cada batería) y entrega dos salida de 1 bit (una para cada batería). En caso de que la primera batería no tenga carga (lo que corresponde a un 0000 binario) la primera salida será uno, independientemente del valor de la otra batería. Es decir, las salidas funcionan de manera independiente para cada batería.

A continuación se muestra la simulación realizada en GTKwave para este módulo.

![Simulación del módulo de descarga](imagenes_simulacion/Descarga_señales.png "Simulación módulo de descarga")

Como se puede evidenciar en la anterior imagen, la única combinación  de las 16 posibles que genera un 1 en la salida es la de 0 (en decimal) o *oooo* en binario.

### Simulación del sumador de 1 y 4 bits




### Simulación del bloque comparador


## Implementación

## Preguntas

1. ¿Qué desafíos pueden surgir al implementar en *hardware* un diseño que funcionaba correctamente en simulación?

2. Describa el enfoque estructural y comportamental en el contexto de electrónica digital y cómo los implementó en el reto. ¿Qué hace Quartus con cada uno?

3. ¿Cómo afecta el diseño del sumador y de comparadores al uso de recursos en la FPGA (LUTs, FFs, BRAMs, etc.)? Muestren el uso de recursos de su diseño.

4. ¿Qué impacto tiene aumentar el número de bits de la lectura de cada batería? ¿Qué impacto tiene aumentar el número de baterias del banco? 

5. Describa las diferencias entre los tipos de dato ```wire``` y  ```reg``` en Verilog y compare ambos con el tipo de dato ```logic``` en System Verilog.

6. Únicamente con lo que se vio en clase, describa cómo se usó el bloque ```always```. Enfoque su respuesta hacia la implementación de lógica combinacional.




## Conclusiones


## Referencias


