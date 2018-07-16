// 2(dos)
//Test: varios test fallan
//1.1) R: no logra abstraer el comportamiento comun en la superclase, queda codigo duplicado en los ifs, mala eleccion de nombres
//1.2) MB
//2.1) R- No usa bien la herencia, no domina bien las colecciones ni cumple bien el requerimiento
//2.2) ok
//2.3) M: No lanza error, no maneja correctamente el conocimiento de en que habitacion está la persona para poder removerla cuando entra a una habitacion nueva
//3.1) MB
//3.2) M
//3.3) M
//3.4) M

class Casa {
	
	var property habitaciones = #{}
	
	method habitacionesOcupadas() {
		return habitaciones.filter({habitacion=> habitacion.estaOcupada()})
	}
	
	

	method puedeEntrarEnAlgunaHabitacion(unaPersona) {
		return habitaciones.any({habitacion =>habitacion.puedeEntrar(unaPersona)})
	}
	
	
}

//TODO: Mala herencia! una habitacion no es una casa, no tiene habitaciones internas
class Habitacion inherits Casa{
	
	//TODO: esta es una variable innecesaria
	var property confort = 10
	var property ocupantes = #{}
	
	
	method usarHabitacion(unaPersona) {
		//TODO, según tu lógica, debería devolver 10
		 return 0
	}

	//TODO: Acá hay una regla de que si la habitacion está vacía debería entrar, ya que es para todas las habitaciones
	method puedeEntrar(unaPersona) = true
	
	//TODO: mejorar el nombre, alcanza con decir "entrar"
	method entrarAHabitacion(unaPersona) {
		if(self.puedeEntrar(unaPersona)) {
		ocupantes.add(unaPersona)
		//TODO: la persona está quedando en la habitación que estaba anteriormente, habría que removerla de ahi
		}
		return ocupantes
		//TODO: Si no puede entrar tiene que romper (self.error(''))
	}
	
	method salirDeLaHabitacion(unaPersona) {
		ocupantes.remove(unaPersona)
	}
	
	method estaOcupada() {
		return not ocupantes.isEmpty()
	}
	
}

class Banio inherits Habitacion {
	
	
	
	override method usarHabitacion(unaPersona) {
		//TODO: debería usar unb mensaje con super en lugr de la variable confort
		//TODO: hay código duplicado en ambas ramas del if, debería estar por fuera
		if(unaPersona.esChiquito()) {
			return 2 + confort
		}
		
		else return 4 + confort
	}
	
	method esHabitacionVacia() = ocupantes.isEmpty()
	 
	override method puedeEntrar(unaPersona) {
		return ocupantes.any({persona=>persona.esChiquito()}) or self.esHabitacionVacia()	
	}
	
	
}

class Dormitorio inherits Habitacion{

	var duenios = #{}
	
	method esDuenio(unaPersona) {
		return duenios.contains(unaPersona)
	}
	
	override method usarHabitacion(unaPersona) {
		//TODO: debería usar unb mensaje con super en lugr de la variable confort
		//TODO: hay código duplicado en ambas ramas del if, debería estar por fuera
		if(! self.esDuenio(unaPersona)) {
        return confort
		}
		return confort + 10 / duenios.size()
		
	}
	
	method esHabitacionLlena() {
		//TODO: ese 2 hardcodeado está mal porque no es fija la cantidad de duenios.
		//Además el filtro no hace nada, si a la coleccion de duenios la filtras con la condicion de si
		//es duenio o no, te va a quedar siempre la misma coleccion.
		//deberias hacer un all sobre duenios preguntando si están o no en la habitacion
		return duenios.filter({persona=>self.esDuenio(persona)}).size() == 2
	}
	
	override method puedeEntrar(unaPersona) {
		//TODO: la regla es que están todos los duenios, no que esté llena
		return self.esDuenio(unaPersona) or self.esHabitacionLlena()		
	}
	
	
	
}

class Cocina inherits Habitacion {
	
	var mCuadrados
	
	override method usarHabitacion(unaPersona) {
				//TODO: debería usar unb mensaje con super en lugr de la variable confort
		//TODO: hay código duplicado en ambas ramas del if, debería estar por fuera
		
		if(! unaPersona.tieneHabilidadDeCocina()) {
           return confort 
           		}
			return (mCuadrados * porcentajeDeCocina.porcentaje()) + confort
	}
	
	
	
	override method puedeEntrar(unaPersona) {
			
		return !ocupantes.any({persona =>persona.tieneHabilidadDeCocina()}) or !unaPersona.tieneHabilidadDeCocina()	
		
	}
	
}

object porcentajeDeCocina {
	
	var property porcentaje = 0.10
	
}

class Familia {
	var miembros
	var casa
	
	//problema con paramentros, me imposibilito hacer bien el ultimo test
	method promedioDeConfort() {
		//TODO: cada ele,mento de esta coleccion es una habitacion, no un miembro
	  return  casa.habitaciones().sum({miembro=>miembro.usarHabitacion(habitacion)})/ miembros.size() 
	}
	
	//TODO: si la casa es una variable de instancia no necesita que sea un parametro. 
	//self es una familia, no una persona en este punto.
	method estaAGusto( unaCasa) = unaCasa.puedeEntrarEnAlgunaHabitacion(self) and self.promedioDeConfort() > 40
	
	//Un responsable es la persona mas vieja de una habitacion. no cumple requerimiento
	method responsable() {
		return miembros.filter({miembro=>not miembro.esChiquito()}).asSet()
	}
}

//Mala herencia, una persona no es una familia
class Persona inherits Familia{
	
	var property edad
	var property tieneHabilidadDeCocina
	
	method esChiquito() = edad <= 4
	
	method invertirHabilidad() = !tieneHabilidadDeCocina
	
	
	method usarHabitacion(unaHabitacion) {
		return unaHabitacion.usarHabitacion(self)
	}
	
	
	
}


class Obsesivo inherits Persona {
	
   override	method estaAGusto(unaHabitacion) {
   	 return super(unaHabitacion)  and miembros.size() <= 2
   }
	
}

class Goloza inherits Persona {
    
    override method estaAGusto(unaHabitacion) {
    	return super(unaHabitacion) and miembros.any({ocupante=> ocupante.tieneHabilidadDeCocina()})
    }
	
}
//TODO: las clases en signular
class Sencillas inherits Persona {
	
	override method estaAGusto(unaHabitacion) {
    	return super(unaHabitacion) and casa.habitaciones().size() > miembros.size()
    }
	
}
















