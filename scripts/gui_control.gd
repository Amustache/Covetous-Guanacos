extends Control

@onready var inventory_label: Label = $MarginContainer/HBoxContainer/PanelContainer2/InventoryLabel
@onready var guanacos_label: Label = $MarginContainer/HBoxContainer/PanelContainer4/GuanacosLabel
@onready var mountain_label: Label = $MarginContainer/HBoxContainer/PanelContainer3/MountainLabel

func update_labels() -> void:
	# Mountain
	mountain_label.text = "Current mountain: \n"
	mountain_label.text += GameManager.cur_mountain.name + "\n"
	mountain_label.text += "(" + GameManager.cur_mountain.range + ", "+ GameManager.cur_mountain.country + ")\n"
	mountain_label.text += "Elevation: %.2fm\n" % GameManager.cur_mountain.elevation
	
	# Guanacos
	var average_speed = 0.0
	var average_strength = 0.0
	for g in GameManager.guanacos:
		average_speed += g.speed
		average_strength += g.strength
	average_speed /= len(GameManager.guanacos)
	average_strength /= len(GameManager.guanacos)
	guanacos_label.text = "Guanacos: \n"
	guanacos_label.text += "Quantity: " + str(len(GameManager.guanacos)) + "\n"
	guanacos_label.text += "Av. speed: " + str(int(average_speed)) + " actions/second\n"
	guanacos_label.text += "Av. strength: " + str(int(average_strength)) + " damages/action\n"

	# Stack
	inventory_label.text = "Stack:\n"
	for item in GameManager.items:
		if GameManager.items[item]["qt"] > 0:
			inventory_label.text += item.capitalize() + ": " + str(GameManager.items[item]["qt"]) + "\n"
