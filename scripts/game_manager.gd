extends Node

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

class Guanaco:
	var name: String
	var speed: float
	var strength: float
	
	func _init(name, speed, strength) -> void:
		self.name = name
		self.speed = speed
		self.strength = strength

var guanacos = [Guanaco.new("Foje", 1, 2)]

@onready var COPPER_SCENE: Resource = preload("res://scenes/ores/copper.tscn")
@onready var GOLD_SCENE: Resource = preload("res://scenes/ores/gold.tscn")
@onready var IRON_SCENE: Resource = preload("res://scenes/ores/iron.tscn")
@onready var ROCK_SCENE: Resource = preload("res://scenes/ores/rock.tscn")
@onready var SILVER_SCENE: Resource = preload("res://scenes/ores/silver.tscn")

@onready var items = {
	rock = {prob = 0.75, resource = ROCK_SCENE, qt = 0},
	iron = {prob = 0.21, resource = IRON_SCENE, qt = 0},
	copper = {prob = 0.19, resource = COPPER_SCENE, qt = 0},
	silver = {prob = 0.08, resource = SILVER_SCENE, qt = 0},
	gold = {prob = 0.05, resource = GOLD_SCENE, qt = 0},
}
