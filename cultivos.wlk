import wollok.game.*
import personaje.*
import granja.*
import mercado.*

//Clase maiz
class Maiz {
	var property position 
	var etapaActual = maizBebe
	const etapaMaxima = maizAdulto

	method position() = position

	method precio()=150

	method image()= etapaActual.image()
	
	method regar() {
		if(etapaActual!= etapaMaxima){
			etapaActual= etapaActual.siguienteEtapa()
		}
	}


	method cosechar(){
		granjaVilla.guardarCosecha(self)
		game.removeVisual(self)
	}

	method puedeSerCosechada() = (etapaActual == etapaMaxima)

}

//etapa de crecimiento de maiz
object maizBebe{
	method image() = "corn_baby.png"

	method siguienteEtapa() = maizAdulto
}

object maizAdulto {
	method image() = "corn_adult.png"
	method siguienteEtapa() = self
}

//Clase Tomaco
class Tomaco {
	var property position

	method image() = "tomaco.png" 
	
	method precio() = 80

	method puedeSerCosechada() = true

	method regar() {
		self.puedeSerRegada()
		position = self.siguientePosicionDeTomaco()
	}

	method siguientePosicionDeTomaco() {
		if(self.estaEnElBorde()) {
			return game.at(position.x(),0)
		}
		else {
			return position.up(1)
		}
	}

	method estaEnElBorde()= position.y() == game.height() - 1

	method puedeSerRegada() {
		if(self.estaOcupadaLaSiguientePosicion()){
			self.error("No se puede regar este Tomaco, ¡NO HAY ESPACIO!")
		}
	}

	method estaOcupadaLaSiguientePosicion() = not game.getObjectsIn(self.siguientePosicionDeTomaco()).isEmpty()

	method cosechar(){
		granjaVilla.guardarCosecha(self)
		game.removeVisual(self)
	}
}


//Clase Trigo

class Trigo {
	var property position 
	var etapaActual= trigo0
	
	method image()= etapaActual.image()

	method precio()= etapaActual.precio()
	
	method regar() {
		etapaActual= etapaActual.siguienteEtapa()
	}

	method cosechar() {
		granjaVilla.guardarCosecha(self)
		game.removeVisual(self)
	}

	method puedeSerCosechada() = etapaActual.esCosechable()
}

object trigo0{
	method image() = "wheat_0.png"
	method siguienteEtapa() =  trigo1
	method esCosechable() = false
	method precio()= 0
}

object trigo1 {
	method image() = "wheat_1.png"
	method siguienteEtapa() = trigo2
	method esCosechable() = false
	method precio()= 0
}

object trigo2 {
	method image() = "wheat_2.png"
	method siguienteEtapa() = trigo3 
	method esCosechable() = true
	method precio()=100
}

object trigo3 {
  method image() = "wheat_3.png"
  method siguienteEtapa() = trigo0
  method esCosechable() = true
  method precio()= 200
}
