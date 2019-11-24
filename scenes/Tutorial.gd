extends Node2D

const emojiGenerate = preload("res://scenes/EmojiGenerate.tscn")

func _ready():
	randomize()
	var emoji = emojiGenerate.instance()
	emoji.init(global.allEmojis[global.selectedEmojiPosition])
	get_node("Container").add_child(emoji, true)
	pass

func _on_Play_pressed():
	get_tree().change_scene("res://scenes/Game.tscn")
