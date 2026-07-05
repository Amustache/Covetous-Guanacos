extends Control

var random = RandomNumberGenerator.new()

# References
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

@onready var mountain_zone: PanelContainer = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/ClickerZone/MarginContainer/HBoxContainer/MountainZone
@onready var clicker_zone: PanelContainer = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/ClickerZone/MarginContainer/HBoxContainer/ClickerZone
@onready var stack_zone: PanelContainer = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/ClickerZone/MarginContainer/HBoxContainer/StackZone
@onready var shop_zone: PanelContainer = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/ClickerZone/MarginContainer/HBoxContainer/ShopZone
@onready var garden_zone: PanelContainer = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/ClickerZone/MarginContainer/HBoxContainer/GardenZone

@onready var mountain_container: PanelContainer = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/StatsZone/MarginContainer/HBoxContainer/MountainStats
@onready var clicker_container: PanelContainer = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/StatsZone/MarginContainer/HBoxContainer/ClickerStats
@onready var stack_container: PanelContainer = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/StatsZone/MarginContainer/HBoxContainer/StackStats
@onready var shop_container: PanelContainer = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/StatsZone/MarginContainer/HBoxContainer/ShopStats
@onready var garden_container: PanelContainer = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/StatsZone/MarginContainer/HBoxContainer/GardenStats

@onready var mountain_label: Label = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/StatsZone/MarginContainer/HBoxContainer/MountainStats/Label
@onready var clicker_label: Label = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/StatsZone/MarginContainer/HBoxContainer/ClickerStats/Label
@onready var stack_label: Label = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/StatsZone/MarginContainer/HBoxContainer/StackStats/Label
@onready var shop_label: Label = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/StatsZone/MarginContainer/HBoxContainer/ShopStats/Label
@onready var garden_label: Label = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/StatsZone/MarginContainer/HBoxContainer/GardenStats/Label

@onready var ore_generator_mountain: Node2D = $Physics/OreGenerator1
@onready var ore_generator_stack: Node2D = $Physics/OreGenerator2


@onready var steps = {
	mountain = [mountain_zone, mountain_container],
	clicker = [clicker_zone, clicker_container],
	stack = [stack_zone, stack_container],
	shop = [shop_zone, shop_container],
	garden = [garden_zone, garden_container],
}

func change_visibility(name: String, visibility:bool = true) -> bool:
	print(name)
	for el in steps[name]:
		print(el)
		el.visible = visibility
	return steps[name][0].visible
	
func update_labels() -> void:
	# Mountain
	mountain_label.text = "Current mountain: \n"
	mountain_label.text += cur_mountain.name + "\n"
	mountain_label.text += "(" + cur_mountain.range + ", "+ cur_mountain.country + ")\n"
	mountain_label.text += "Elevation: %.2fm\n" % cur_mountain.elevation
	
	# Guanacos
	var average_speed = 0.0
	var average_strength = 0.0
	for g in guanacos:
		average_speed += g.speed
		average_strength += g.strength
	average_speed /= len(guanacos)
	average_strength /= len(guanacos)
	clicker_label.text = "Guanacos: \n"
	clicker_label.text += "Quantity: " + str(len(guanacos)) + "\n"
	clicker_label.text += "Av. speed: " + str(int(average_speed)) + " actions/second\n"
	clicker_label.text += "Av. strength: " + str(int(average_strength)) + " damages/action\n"

	# Stack
	stack_label.text = "Stack:\n"
	for item in stack:
		if stack[item] > 0:
			stack_label.text += item.capitalize() + ": " + str(stack[item]) + "\n"

# Mountain = objective
class Mountain:
	var name: String
	var range: String
	var country: String
	var elevation: float
	
	func _init(name, range, country, elevation) -> void:
		self.name = name
		self.range = range
		self.country = country
		self.elevation = elevation
	
var cur_mountain = Mountain.new(
	"Pico El Águila",
	"Cordillera de Mérida", 
	"Venezuela",
	4018,
)

# Objects, stats = Tools
class Guanaco:
	var name: String
	var speed: float
	var strength: float
	
	func _init(name, speed, strength) -> void:
		self.name = name
		self.speed = speed
		self.strength = strength

var guanacos = [Guanaco.new("Foje", 1, 2)]

const BASE_STACK_STATS = {
	rock = 0.75,
	iron = 0.21,
	copper = 0.19,
	silver = 0.08,
	gold = 0.05,
}

var stack = {
	rock = 0,
	iron = 0,
	copper = 0,
	silver = 0,
	gold = 0,
}

## ---



func _ready() -> void:
	update_labels()
	change_visibility("garden", true)
	change_visibility("shop", true)
	change_visibility("stack", true)
	change_visibility("clicker", true)
	change_visibility("mountain", true)

func _on_mountain_button_pressed() -> void:
	audio_player.stream = IMPACT_SFX[random.randi_range(0, len(IMPACT_SFX) - 1)]
	audio_player.play()
	for item in BASE_STACK_STATS:
		if random.randf() < BASE_STACK_STATS[item]:
			stack[item] += 1
			cur_mountain.elevation -= random.randf()
			ore_generator_mountain.shoot_ore(item)
			ore_generator_stack.shoot_ore(item)
	update_labels()
