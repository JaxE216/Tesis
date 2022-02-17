extends StaticBody2D

var tipoPuente

func _ready():
	tipoPuente = get_node(".").name
	print(tipoPuente)
	match tipoPuente:
		'PuenteHorizontal_SM':
			habilitarPuenteH(true)
		'PuenteHorizontal_CM':
			habilitarPuenteH(false)
		'PuenteVertical_SM':
			habilitarPuenteV(true)
		'PuenteVertical_CM':
			habilitarPuenteV(false)

func habilitarPuenteH(mostrar):
	if mostrar:
		# Desactivar puente incompleto
		get_node("puenteIncompleto").visible = false
		
		get_node("colisionIzquierda").disabled = true
		get_node("colisionDerecha").disabled = true
		
		get_node("colisionIzquierda").visible = false
		get_node("colisionDerecha").visible = false
		
		# Activar puente completo
		get_node("puenteCompleto").visible = true
		
		get_node("colisionArriba").disabled = false
		get_node("colisionAbajo").disabled = false
		
		get_node("colisionArriba").visible = true
		get_node("colisionAbajo").visible = true
		
	else:
		# Activar puente incompleto
		get_node("puenteIncompleto").visible = true
		
		get_node("colisionIzquierda").disabled = false
		get_node("colisionDerecha").disabled = false
		
		get_node("colisionIzquierda").visible = true
		get_node("colisionDerecha").visible = true
		
		# Desactivar puente completo
		get_node("puenteCompleto").visible = false
		
		get_node("colisionArriba").disabled = true
		get_node("colisionAbajo").disabled = true
		
		get_node("colisionArriba").visible = false
		get_node("colisionAbajo").visible = false

func habilitarPuenteV(mostrar):
	if mostrar:
		# Desactivar puente incompleto
		get_node("puenteIncompleto").visible = false
		
		get_node("colisionArriba").disabled = true
		get_node("colisionAbajo").disabled = true
		
		get_node("colisionArriba").visible = false
		get_node("colisionAbajo").visible = false
		
		# Activar puente completo
		get_node("puenteCompleto").visible = true
		
		get_node("colisionIzquierda").disabled = false
		get_node("colisionDerecha").disabled = false
		
		get_node("colisionIzquierda").visible = true
		get_node("colisionDerecha").visible = true
		
	else:
		# Activar puente incompleto
		get_node("puenteIncompleto").visible = true
		
		get_node("colisionArriba").disabled = false
		get_node("colisionAbajo").disabled = false
		
		get_node("colisionArriba").visible = true
		get_node("colisionAbajo").visible = true
		
		# Desactivar puente completo
		get_node("puenteCompleto").visible = false
		
		get_node("colisionIzquierda").disabled = true
		get_node("colisionDerecha").disabled = true
		
		get_node("colisionIzquierda").visible = false
		get_node("colisionDerecha").visible = false
