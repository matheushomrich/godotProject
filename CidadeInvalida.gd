extends Label


# Seta uma cidade aleatoria da lista
var cities = ["Pelotas", "Gramado", "Alvorada", "Sao Leopoldo", "Porto Alegre"]
func set_random_city():
	var i: int = randi() % cities.size()
	if cities[i]: 
		text = cities[i]
		
func _ready():
	set_random_city()
