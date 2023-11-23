extends HSlider

## Variables ##
@export var bus_name : String
var bus_index : int

## Volume Slider ##
func _ready():
	bus_index = AudioServer.get_bus_index(bus_name)

	value = db_to_linear(
		AudioServer.get_bus_volume_db(bus_index)
	)

func _on_value_changed(vol):
	AudioServer.set_bus_volume_db(
		bus_index,
		linear_to_db(vol)
	)
