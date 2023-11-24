extends Node

@export_group("Bomb")
## How fast the bomb moves when spawned
@export var initial_bomb_speed : float = 300
## Speed the bomb gains when hitting a wall
@export var additive_bomb_speed : float = 1.05

@export_category("Other")
@export var maps : Array[PackedScene ]

@export var resolutions : Array[Vector2]
var default_resolution : int = 0

var menu_scene : String = "res://Scenes/main_menu.tscn"
var game_scene : String = "res://Scenes/level_select_menu.tscn"
