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

    method registrarVenta() {
        const totalAPagar = granjaVilla.valorDeCultivoEnOro()
        
        monedasDeOro = monedasDeOro - totalAPagar
        mercaderia.addAll(granjaVilla.cultivosCosechados())
    }
}
