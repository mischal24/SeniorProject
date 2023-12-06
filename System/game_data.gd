extends Node
@export_group("player")
var player_tscn : String = "res://Nodes/player.tscn"
## The minimum amount of players needed for the game to start
@export var min_player_count : int = 2

@export_group("Bomb")
var bomb_tscn : String = "res://Nodes/bomb.tscn"
## How fast the bomb moves when spawned
@export var initial_bomb_speed : float = 300
## Speed the bomb gains when hitting a wall
@export var additive_bomb_speed : float = 1.05
## Speed in which the bomb will NOT exceed
@export var max_bomb_speed : float = 400

@export_category("Other")
@export var maps : Array[Map]

@export var resolutions : Array[Vector2]
var default_resolution : int = 0

@export var sound_effects : Dictionary

var menu_scene : String = "res://Scenes/main_menu.tscn"
var game_scene : String = "res://Scenes/level_select_menu.tscn"
