extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(var number, var color):
	get_node("Label").text = number
	get_node("Label").add_color_override("font_color", color)