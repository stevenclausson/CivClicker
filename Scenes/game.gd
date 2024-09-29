extends Control

var rng = RandomNumberGenerator.new()
var numberOfClicks = 0

var food = 0
var berries = 0
var wildMeat = 0
var skins = 0
var timber = 0
var stone = 0






func _ready():
	var timer = Timer.new()
	add_child(timer)
	timer.set_wait_time(10)
	timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
	timer.start()

func _on_Timer_timeout():
	#PopGrowth()
	#CalculateFood()
	pass


func _on_explore_btn_pressed() -> void:
	numberOfClicks += 1
	rng = randi_range(1, 14)
	if (rng == 3):
		skins += 1
	elif (rng == 7):
		timber += 1
	elif (rng == 1):
		stone += 1
