# Parcial: Hogar

Este sistema simula la relación entre una familia y la casa donde vive para sacar conclusiones.
Una casa tiene varias habitaciones, las mismas pueden ser de distintos tipos: Habitaciones de uso general, 
dormitorios, baños y cocinas. Por supuesto puede haber más de una habitación del mismo tipo en una casa. 
Una casa podría tener, por ejemplo, 3 baños, 2 cocinas, 4 dormitorios y 1 habitación de uso general. 


## 1. Nivel de confort de las Habitaciones

De cada habitacion interesa saber el nivel de confort que le aporta a una persona, 

Todas las habitaciones aportan 10 unidades de confort como base. 
Además existen reglas por cada tipo de habitación que podrían adicionar puntos

- Uso general: no aporta nada adicional

- Baño: Aporta 2 unidades de confort extra si se trata de un niño de 4 o menos años. 4 unidades extra si la persona 
  tiene 5 o más años.   

- Dormitorio:  Si la persona no es uno de los dueños del dormitorio no aporta nada extra de confort. Si lo es, aporta como extra 
  10 dividido la cantidad de dueños. (En caso de una habitacion de dos dueños, sumaría 5 a cada duenio) 
  
- Cocina: En caso de que se trate de una persona con habilidades de cocina, aporta una cantidad de unidades de confort extra 
  que se calcula como un porcentaje de la cantidad de metros cuadrados de esa cocina. 
  Ese porcentaje es un valor que se configura al inicio de la ejecución y es el mismo para todas las cocinas. 
  Ese valor puede cambiar en cualquier momento y las cocinas ya creadas
  deben poder usar el valor nuevo. Un buen valor por defecto es 10%.
  Aclaración: cualquier persona puede tener habilidades de cocina o no. 
  Una persona que al principio no tiene habilidades de cocina podría aprender y adquirirlas.

Requerimientos:

- 1.1 Saber los puntos de confort que aporta una habitación a una persona
- 1.2 Configurar el porcentaje utilizado en el cálculo de los puntos de confort de las cocinas. 
		
## 2. Entrar a una habitación
Cada habitación tiene  ocupantes que van variando según se use el sistema. 
Al inicio del sistema, las habitaciones están vacías. 

Una persona siempre puede entrar a una  habitación que está vacía (no importa de que tipo de habitación se trate). 

En caso de que haya algún ocupante dependerá de cada caso:

- Uso general: no hay requisito adicional, siempre puede entrar.

- Baño: Puede entrar si alguno de sus ocupantes es un niño de 4 años o menos, 
  ya que se supone que lo va a asistir en sus tareas higiénicas.
  
- Dormitorio: Puede entrar cualquier persona que sea dueño. En caso de no serlo deben estar presente todos los dueños
 dentro de la habitación para poder ingresar.

- Cocina: Si se trata de una persona con habilidades de cocina solo puede entrar si no hay ya entre sus
ocupantes otra persona con habilidades de cocina. Es decir, puede haber muchos ocupantes pero solo un cocinero.

Requerimientos:

- 2.1 Saber si una persona puede entrar en una habitación
- 2.2 Saber los ocupantes de una habitacion.
- 2.3 Que una persona entre en una habitación. (debe abandonar la habitacion previa donde estaba, 
si es que estaba y quedarse en la nueva. 

NOTA: Asumir que todas las personas no tienen una habitación inicial (null) 

NOTA: Tener en cuenta que que sucede si la persona no podía entrar y se solicita que ingrese igual.

NOTA: Depende de como armes el modelo, podrías necesitar o no una casa que contenga a las habitaciones
para poder saber en que habitación está una persona.  Hay soluciones buenas que la necestian y soluciones
buenas que no la necesitan. De todas maneras el concepto de casa surge en el siguiente punto.

  
## 3. Consultas sobre la familia y la casa
Una familia está compuesta por un conjunto de personas y una casa. La casa posee un conjunto de habitaciones 

Requerimientos: 
- 3.1 Saber las habitaciones que están ocupadas de una casa (tienen al menos un ocupante)
- 3.2 Saber los responsables de la casa, el cual es el conjunto formado por el ocupante más viejo de cada habitación ocupada.
- 3.3 Saber el nivel de confort promedio de la familia, calculado como el nivel de confort de cada miembro 
dividido cantidad de miembros. El nivel de confort de un miembro es la sumatoria del confort que le aporta 
cada habitación de la casa.
- 3.4 Saber si una familia está a gusto, 
Para lo cual tiene que suceder que el nivel de confort promedio de la casa sea superior a 40
y cada miembro se sienta a gusto, lo cual depende de cada persona:

 * Obsesivos: puede entrar en al menos una habitación y todas las habitaciones tienen como máximo 2 ocupantes.
 * Golozas: puede entrar en al menos una habitaciṕn y al menos un miembro de la familia tiene habilidades de cocina.
 * Sencillas: puede entrar en al menos una habitación y la casa tiene al menos 1 habitación más que la cantidad de miembros de la familia


 

  
  


 
