import mercado.*
import granja.*
import wollok.game.*
import cultivos.*
import aspersores.*

object personaje {
	var property position = game.center()
	const property image = "fplayer.png"
	var monedasDeOro= 0
	

	method monedasDeOro() = monedasDeOro 


	method sembrarMaiz() {
		const nuevoMaiz= new Maiz(position= self.position())
		game.addVisual(nuevoMaiz)
		granjaVilla.registrarSiembra(nuevoMaiz)
	}

    method sembrarTrigo() {
        const nuevoTrigo= new Trigo(position = self.position())
        game.addVisual(nuevoTrigo)
        granjaVilla.registrarSiembra(nuevoTrigo)
    }

    method sembrarTomaco() {
        const nuevoTomaco= new Tomaco(position= self.position())
        game.addVisual(nuevoTomaco)
        granjaVilla.registrarSiembra(nuevoTomaco)
    }


	method cosecharPlanta() {
		const plantasAca = granjaVilla.cultivosEn(self.position())
		if (plantasAca.isEmpty()) {
			self.error("no tengo nada para cosechar")
		}
		const listasParaCosechar = plantasAca.filter({ planta => planta.puedeSerCosechada() })

		listasParaCosechar.forEach({ planta =>  planta.cosechar() })
	}

	method regarPlanta() {
		const plantasAca= granjaVilla.cultivosEn(self.position())
		if (plantasAca.isEmpty()){
			self.error("No tengo nada para regar aca!")
		}
		plantasAca.forEach({planta => planta.regar()})
	}

	method vender() {
        const mercadoActual = self.mercadoEnMiPosicion()

        self.validarSiHayMercado(mercadoActual)
        self.validarSiHayPlantasCosechadas()

        const valorDeVentaDeLaCosecha = granjaVilla.valorDeCultivoEnOro()
        mercadoActual.validarFondos(valorDeVentaDeLaCosecha)
        
        monedasDeOro = monedasDeOro + valorDeVentaDeLaCosecha
        mercadoActual.registrarVenta()
        granjaVilla.venderCultivosCosechados()
    }

    method validarSiHayMercado(mercado) {
        if (mercado == null) {
            self.error("¡No puedo vender!. No hay un mercado aca")
        }
    }

    method validarSiHayPlantasCosechadas() {
        if (granjaVilla.cultivosCosechados().isEmpty()) {
            self.error("¡No tengo nada para vender!")
        }
    }


	method mercadoEnMiPosicion() {
        const objetosAca = game.getObjectsIn(self.position())
        const mercadosAca = objetosAca.filter({ obj => obj.className() == "mercado.Mercado" })
        if (not mercadosAca.isEmpty()) {
            return mercadosAca.first()
        } else {
            return null
        }
    }

	method comprobarOroYCosecha()=  game.say(self, "Tengo " +monedasDeOro+ " monedas y " +granjaVilla.cantidadCultivosCosechados()+ " plantas para vender")

	method colocarAspersor() {
        self.validarCeldaParaColocarAspersor()
        const nuevoAspersor= new Aspersor(position = self.position(), id= granjaVilla.cantidadDeAspersores())
        game.addVisual(nuevoAspersor)
        nuevoAspersor.comenzarRiego()
    }

    method validarCeldaParaColocarAspersor() {
        if (not self.esCeldaVacia()) {
            self.error("No puedo poner un aspersor acá")
        }
    }

    method esCeldaVacia() {
        const objetosAca = game.getObjectsIn(self.position())
        return objetosAca.size() <= 1
    }
}

