import granja.*
import wollok.game.*

class Mercado {
    var property position
    var property monedasDeOro 
    const property mercaderia = []

    method image() = "market.png"

    method puedePagar(monto) {
        return monedasDeOro >= monto
    }

    method validarFondos(monto) {
		if (not self.puedePagar(monto)) {
			self.error("El mercado no tiene suficiente oro para pagarme")
		}
	}

    method registrarVenta() {
        const totalAPagar = granjaVilla.valorDeCultivoEnOro()
        
        monedasDeOro = monedasDeOro - totalAPagar
        mercaderia.addAll(granjaVilla.cultivosCosechados())
    }
}
