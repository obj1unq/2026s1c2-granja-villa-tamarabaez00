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


	method sembrar(nuevaPlanta) {
		nuevaPlanta.position(self.position())
		game.addVisual(nuevaPlanta)
		granjaVilla.registrarSiembra(nuevaPlanta)
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
        self.validarFondosDelMercado(mercadoActual)
        
        const oroGanado = granjaVilla.valorDeCultivoEnOro()
        monedasDeOro = monedasDeOro + oroGanado
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

    method validarFondosDelMercado(mercado) {
        const oroGanado = granjaVilla.valorDeCultivoEnOro()
        if (not mercado.puedePagar(oroGanado)) {
            self.error("El mercado no tiene suficiente oro para pagarme")
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
        aspersor.colocar(self)
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

