extends Node2D

var red = Color("#FF5656")
var green = Color("#56FF85")
var blue = Color("#56B8FF")


var colors = [red, green, blue]
var emojis = []

const numberGenerate = preload("res://scenes/NumberGenerate.tscn")
const emojiGenerate = preload("res://scenes/EmojiGenerate.tscn")

func _ready():
	loadEmojis()
	
	while true:
		for i in range(randi()%2+0):
			createEmoji()
			yield(get_tree().create_timer(rand_range(0.02, 0.2)), "timeout")	
		yield(get_tree().create_timer(rand_range(0.02, 0.2)), "timeout")
		for i in range(randi()%2+0):
			createNumber()

func createNumber():
	randomize()
	var textLabel = numberGenerate.instance()
	var color = colors[randi()%3+0]
	var number = str(randi()%9+1)
	if(color == blue and int(number) > 3):
		return null
	textLabel.init(number, color)
	handleNumber(number, color)
	var pos = Vector2()
	pos.x = rand_range(0, get_viewport().get_visible_rect().size.x-50)
	pos.y = rand_range(0, get_viewport().get_visible_rect().size.y-110)
	textLabel.set_position(pos)
	get_node("Container").add_child(textLabel, true)
	yield(get_tree().create_timer(rand_range(0.1, 0.41)), "timeout")
	for i in range(10):
		textLabel.modulate.a -= 0.1
		yield(get_tree().create_timer(rand_range(0.01, 0.041)), "timeout")
	textLabel.queue_free()

func createEmoji():
	randomize()
	var emoji = emojiGenerate.instance()
	var currentEmoji = emojis[randi()%emojis.size()]
	emoji.init(currentEmoji)
	handleEmoji(currentEmoji)
	var pos = Vector2()
	pos.x = rand_range(0, get_viewport().get_visible_rect().size.x-50)
	pos.y = rand_range(0, get_viewport().get_visible_rect().size.y-110)
	emoji.set_position(pos)
	get_node("Container").add_child(emoji, true)
	yield(get_tree().create_timer(rand_range(0.1, 0.41)), "timeout")
	for i in range(10):
		emoji.modulate.a -= 0.1
		yield(get_tree().create_timer(rand_range(0.01, 0.041)), "timeout")
	emoji.queue_free()
	
func loadEmojis():
	if(global.selectedEmojiPosition+5 > global.allEmojis.size()):
		for i in range(global.selectedEmojiPosition, global.selectedEmojiPosition-5):
			emojis.append(global.allEmojis[i])
	else:
		for i in range(global.selectedEmojiPosition, global.selectedEmojiPosition+5):
			emojis.append(global.allEmojis[i])

func handleNumber(var number, var color):
	if(color == red):
		global.countNumber -= int(number)
	elif(color == green):
		global.countNumber += int(number)
	elif(color == blue):
		global.countNumber *= int(number)

func handleEmoji(var currentEmoji):
	if(currentEmoji == global.selectedEmoji):
		global.countEmoji += 1