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
### Sumador de 4 bits

En este caso, en el mismo archivo del [sumador](./src/sumador.v) se define un módulo que tiene como entradas dos numeros de 4 bits que se desean sumar y un acarreo final. En el módulo se puede observar que se utilizó una metodología escalable puesto que se instancia cuatro veces el módulo sumador de 1 bit('adder') para crear la suma de 4 bits('adder4b'). 

Es importante resaltar que el proceso se realizo bit a bit, en el archivo se muestra que se creo un modulo de suma de 1 bit para cada realizar la suma entre el n-esimo bit de A y B, pero para interconectar los módulos se utilizó un dato de tipo 'wire' como si fuera un acarreo temporal. De esta manera, este operador permitió conectar el acarreo de sálida $C_{out}$ del n-simo sumador de 1 bit al acarreo de entrada $C_{in}$ del siguiente sumador.    
### Alarmas mediante restador

La segunda etapa del trabajo consiste en generar 3 alarmas para tres niveles de energía en las baterías (estos niveles se miden en función de la suma de ambas). 
+ Crítico (0-3)
+ Regular (4-15)
+ Aceptable (16-30)

Las alarmas son mutuamente excluyentes, es decir, si una de estas está encendida, las otras deben estar apagadas. Por el contrario, la alarma de las baterías es una salida independiente. Si, por ejemplo, una de las batería tiene nivel de carga 0 y otro de 1, la alarma de descarga 1 se encenderá, pero tambien lo hará la alarma de nivel crítico.

Para hallar las expresiones booleanas de cada una de estas alarmas se usaron dos valores: el *carry_out* de la suma de los dos números (A+B) y el *carry_out* de la suma de A+B+(-4).

#### Razonamiento utilizado

 + Si se suman los números A+B con el módulo de suma antes explicado, el valor del *carry_out* de esa suma ($C_S$) será 1 si A+B $\geq$ 16. Por el contrario, si $C_S$ es 0, entonces A+B $\leq$ 15.
 + Si se suma el nivel total de las baterías encontrado con el módulo de suma en el paso anterior con -4, es decir, con el complemento a2 de 4, el resultaod del *carry_out* indicará que la suma de las baterías es mayor o menor que 3. Si el *carry_out* es igual a 1 ($C_R$), A+B $\geq$ 4, si por el contrario $C_R$ es igual a 0, A+B $\leq$ 3.

 La anterior información se puede resumir enla siguiente tabla de verdad. 
 Donde $C_S$ es el *carry_out* de la suma de la baterías (A+B), $C_R$ es la suma de esta carga total con el complemento a2 de 4 (A+B+(-4)), y, por último, $I_1$, $I_2$ e $I_3$ son las salidas de los niveles crítico, regular y aceptable, respectivamente.   

 $C_S$ | $C_R$| $I_1$ | $I_2$| $I_3$|
| ----| ---- | -----| -----| ----|
|0| 0|1|0| 0|
|0| 1|0|1| 0|
|1| 0|0|0| 1|
|1| 1|0|0| 1|

Según la tabla anterior, las expresiones booleannas para cada alarma son:

$$I_1 = \bar{C_S}\bar{C_R}$$
$$I_2 = \bar{C_S}C_R$$
$$I_3 = C_S\bar{C_R} + C_SC_R = C_S$$

#### Aclaración
Un punto importante en el anterior diseño es la suma con -4 y no con -3, esto se debe a que si se realiza la suma con -4, el *carry_out* dividirá los números en mayores a 3 y menores o iguales a 3. Por el contrario, si se escoge -3 se dividirán los números en mayores a 2 y menores e iguales que 2. 


### Diagramas

#### Detector de alarmas de descarga

A partir de una visualazación por ```RTL```, se puede mostrar que este bloque tiene dos entradas (nivel de carga de cada bateria) y dos sálidas (descarga por cada alarma). Además, también se muestra la construcción modular por cada bateria: 

![[]](./imagenes_simulacion/diagrama_alerta_bloque.png)

En la siguiente imagen se observa que en el nivel de abstracción más bajo, la señal de cada batería se invierte y pasa bit por bit a una compuerta ```and```, tal como se planteo en la ecuacion.

![alt text](./imagenes_simulacion/diagrama_alerta_fisica.png)

#### Sumador de 1 bit

Con el analisis ```RTL```, se observa el siguiente diagrama del sumador de 1 bit, este describe las ecuaciones mencionadas anteriormente. 

![](./imagenes_simulacion/diagrama_sum1bit.png)


#### Sumador de 4 bits

En la visualizacion por ```RTL```, se observa la escalabilidad mencionada en la seccion de la descripcion. Se puede notar que se realiza un proceso bit a bit en el que se suma cada bit de 'A' y 'B', pero se conectan los modulos de sumadores de 1 bit de tal modo que el $c_{out}$ de un sumador es el $c_{in}$ del siguiente sumador de bit significativo.  

![](./imagenes_simulacion/diagrama_sum4bit.png)





## Simulaciones 

<!-- (Incluir las de Digital si hicieron uso de esta herramienta, pero también deben incluir simulaciones realizadas usando un simulador HDL como por ejemplo Icarus Verilog + GTKwave) -->




### Simulación del bloque de alarma de descarga

Tal y como se explicó anteriormente, el segundo módulo de descarga resive dos buses de entradas de 4 bits (cada bus representa el nivel de carga de cada batería) y entrega dos salida de 1 bit (una para cada batería). En caso de que la primera batería no tenga carga (lo que corresponde a un 0000 binario) la primera salida será uno, independientemente del valor de la otra batería. Es decir, las salidas funcionan de manera independiente para cada batería.

A continuación se muestra la simulación realizada en GTKwave para este módulo.

![Simulación del módulo de descarga](imagenes_simulacion/Descarga_señales.png "Simulación módulo de descarga")

Como se puede evidenciar en la anterior imagen, la única combinación  de las 16 posibles que genera un 1 en la salida es la de 0 (en decimal) o *oooo* en binario.

### Simulación del sumador de 1 y 4 bits

Tal y como se mencionó anteriormente, para la implementación del sumador de 4 bits se creó primero un módulo de suma de 1 bit, con tres entradas de 1 bit (a, b, cin) y dos salidas de 1 bit (cout, sum). Mientras que para el módulo de suma de 4 bits resive dos buses de datos para cada número, cada uno de 4 bits.
#### Suma sin *carry_out* 
A continuación se muestra la simulación para distintos valores de a, b y *carry-in* para el sumador de 4 bits.
![Sumador sin carry](imagenes_simulacion/sumador_sin_carry.png)

Tal y como se muestra en la imagen anterior, como la suma de los números no supera a 15 (que es lo máximo que se puede representar con 4 bits), el bus de datos *sum4* efectivamente representa la suma de los números, y el *carry_out* es 0.
#### Suma con *carry_in*

En el caso en el que la suma supero el valor de 15, sí hay *carry_out* y por tanto, el resultado de *sum4* no va a corresponder con la suma real de los números, puesto que la representación de la suma requeriría de 5 bits.

A continuación se muestra una simulación que ejemplifica la explicación anterior.
![Sumador con carry](/imagenes_simulacion/sumador_con_carry.png)

Como se puede observar en la anterior imagen, al sumar 8 + 8 se obtiene en la salida *sum4* el número 0, esto es debido a que 16, el resultado de la suma, en binario se escribe como 10000, por lo que al tomar los primeros 4 bits (que es el resultado que arroja *sum4*) el número representado es 0, en vez de 16. 
Los otros ejemplos en la simulación siguien el mismo principio.

#### Aclaración del módulo suma
La razón por la que se optó implementar esta función en vez de arrojar una única salida de 5 bits, que sí representaría la suma en todos sus casos, fue por que el programa no busca conocer la suma necesariamene, solo generar alarmas para distintos valores de carga. Más adelante se ahondará al respecto.

### Simulación del bloque comparador
A continuación se muestran 6 distintas entradas para A y B. Los valores que toman las batería en las dos primeras son:
+ Prueba 1: A = 0, B = 0, A+B = 0
+ Prueba 2: A = 1, B = 1, A+B = 2

Por lo que se espera que en la primera prueba la alarma de las dos batería esté en 1 lógico, mientras que al mismo tiempo salte la alarma para el nivel crítico (0 - 3). 

En las siguientes dos pruebas se espera que salte el nivel regular (4 - 15) y las demás salidas entén en 0.
+ Prueba 3: A = 2, B = 2; A+B = 4
+ Prueba 4: A = 8, B = 7; A+B = 15

En las últimas dos pruebas se espera que la única salida en 1 sea el de nivel aceptable (16 - 30).
+ Prueba 5: A = 8, B = 8, A+B = 16
+ Prueba 5: A = 15, B = 15, A+B = 30

La simulación de cada una de estas pruebas, seǵun el orden expuesto, se muestra a continuación. En donde *green* es el nivel aceptable, *yellow* regular y *critical* el nivel crítico.
![Comparador](imagenes_simulacion/comparador.png)

Como se puede observar en la imagen anterior, los resultados de la simulación concuerdan con los esperados.

## Implementación

Para reuninir todos los elementos creados, el último proceso de escalización fue crear un modulo [top](./src/nivelcarga.v) en el que se creó una instancia de cada modulo de alarma de descarga, suma de 4 bits y comparación. En este modulo, se describieron las dos entradas de 4 bits (carga en A y carga en B) junto con las salidas de alerta de 1 bit de descarga, nivel critico, regular y aceptable. Además, se implementó una señal de sálida adicional para activar un buzzer en dado caso que se tuviera un nivel critico de carga total. 

Asimismo, se utilizaron datos de tipo ```wire```, para conectar el modulo de la suma con el del comparador y finalmente realizar la lógica de acarreos explicada anteriomente para activar las señales de nivel crítico, regular y aceptable.


Por otro lado, considerando el hecho que la fpga utilizada maneja una lógica invertida y los switches que fueron utilizados para representar el nivel de carga de cada bateria estaban soldados al revés, se negaron las entradas y sálidas de datos en este mismo modulo para no cambiar o alterar la lógica de los modulos construidos anteriormente, ya que se podría haber cometido un error fácilmente que trajero consigo una implementación erronea.

En el siguiente diagrama se resume la implementación de todo el sistema:
![](./imagenes_simulacion/diagrama_completo.png)

En el siguiente video se puede observar la implementación de todo el laboratorio: 

![Video funcionamiento](imagenes_simulacion/Lab_2_Video_c.mp4


## Preguntas

1. ¿Qué desafíos pueden surgir al implementar en *hardware* un diseño que funcionaba correctamente en simulación?

2. Describa el enfoque estructural y comportamental en el contexto de electrónica digital y cómo los implementó en el reto. ¿Qué hace Quartus con cada uno?

3. ¿Cómo afecta el diseño del sumador y de comparadores al uso de recursos en la FPGA (LUTs, FFs, BRAMs, etc.)? Muestren el uso de recursos de su diseño.

4. ¿Qué impacto tiene aumentar el número de bits de la lectura de cada batería? ¿Qué impacto tiene aumentar el número de baterias del banco? 

5. Describa las diferencias entre los tipos de dato ```wire``` y  ```reg``` en Verilog y compare ambos con el tipo de dato ```logic``` en System Verilog.

6. Únicamente con lo que se vio en clase, describa cómo se usó el bloque ```always```. Enfoque su respuesta hacia la implementación de lógica combinacional.




## Conclusiones


## Referencias


