extends Node

#region Generic
@export_category("Generic")
@onready var center : Vector2 = Vector2(
	ProjectSettings.get("display/window/size/viewport_width"),
	ProjectSettings.get("display/window/size/viewport_height"))/2
#endregion

#region Game Manager
@export_category("Game Manager")
@onready var player_scene : PackedScene = preload("res://Game/Nodes/Objects/player.tscn")
var player_list : Dictionary
const max_player_count : int = 4
@export var min_player_count : int = 2

var key_id : int = -1

var game_started : bool = false
#endregion

#region Player
@export_category("Player")
var player_speed : float = 300.0

@export var jump_height : float
@export var jump_time_till_peak : float
@export var jump_time_till_fall : float

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_till_peak) * -1
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_till_peak * jump_time_till_peak)) * -1
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_till_peak * jump_time_till_peak)) * -1
#endregion

#region Bomb
@export_category("Bomb")

@onready var bomb_scene : PackedScene = preload("res://Game/Nodes/Objects/bomb.tscn")
@export var initial_bomb_speed : float
@export var max_bomb_speed : float
@export var additive_bomb_speed : float
@export var bomb_collision_delay : float

var current_bomb_parent
var current_bomb_speed : Vector2
func bomb_direction() -> Vector2:
	var new_vector = Vector2(randf_range(-1,1), randf_range(-1,1)) * GameData.initial_bomb_speed
	return new_vector
#endregion

#region Settings
var current_resolution : int = 0
#endregion

#region Level Select
@export var maps : Array[PackedScene]
@export var maps_images : Array[Texture]
var selected_map : int = 0
#endregion
