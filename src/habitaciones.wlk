class Casa {
	
	var property habitaciones = #{}
	
	method habitacionesOcupadas() {
		return habitaciones.filter({habitacion=> habitacion.estaOcupada()})
	}
	
	
	
	
	method puedeEntrarEnAlgunaHabitacion(unaPersona) {
		return habitaciones.any({habitacion =>habitacion.puedeEntrar(unaPersona)})
	}
	
	
}

class Habitacion inherits Casa{
	
	var property confort = 10
	var property ocupantes = #{}
	
	
	method usarHabitacion(unaPersona) {
		 return 0
	}
	
	method puedeEntrar(unaPersona) = true
	
	method entrarAHabitacion(unaPersona) {
		if(self.puedeEntrar(unaPersona)) {
		ocupantes.add(unaPersona)
		}
		return ocupantes
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
		if(! self.esDuenio(unaPersona)) {
        return confort
		}
		return confort + 10 / duenios.size()
		
	}
	
	method esHabitacionLlena() {
		return duenios.filter({persona=>self.esDuenio(persona)}).size() == 2
	}
	
	override method puedeEntrar(unaPersona) {
		return self.esDuenio(unaPersona) or self.esHabitacionLlena()		
	}
	
	
	
}

class Cocina inherits Habitacion {
	
	var mCuadrados
	
	override method usarHabitacion(unaPersona) {
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
	  return  casa.habitaciones().sum({miembro=>miembro.usarHabitacion(habitacion)})/ miembros.size() 
	}
	
	method estaAGusto( unaCasa) = unaCasa.puedeEntrarEnAlgunaHabitacion(self) and self.promedioDeConfort() > 40
	
	method responsable() {
		return miembros.filter({miembro=>not miembro.esChiquito()}).asSet()
	}
}

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

class Sencillas inherits Persona {
	
	override method estaAGusto(unaHabitacion) {
    	return super(unaHabitacion) and casa.habitaciones().size() > miembros.size()
    }
	
}
















