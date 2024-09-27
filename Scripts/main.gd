extends Control
var rng = RandomNumberGenerator.new()

var food = 0
var wood = 0
var stone = 0

var skins = 0
var herbs = 0
var ores = 0

var tent = 0
var woodHut = 0
var cottage = 0

var farmers = 0
var woodcutters = 0
var miners = 0

var baseGathering = 0.02

var maxPops = 0
var curPops = 0
var idleWorkers = 0

var freeLand = 1000

func _ready():
	var timer = Timer.new()
	add_child(timer)
	timer.set_wait_time(1)
	timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
	timer.start()

func _on_Timer_timeout():
	Calculate()


func _process(delta):
	maxPops = tent + (woodHut *2) + (cottage * 6)
	$PopHeading/MaxPopLbl.text = "Maximum Population: " + str(maxPops)
	GUIData()


func GUIData():
	$FoodBtn/FoodLbl.text = str(food)
	$SpecialResLbl/Skinslbl.text = "Skins: " + str(skins)
	$WoodBtn/WoodLbl.text = str(wood)
	$SpecialResLbl/HerbsLbl.text = "Herbs: " + str(herbs)
	$StoneBtn/StoneLbl.text = str(stone)
	$SpecialResLbl/OresLbl.text = "Ores: " + str(ores)
	$TabContainer/Buildings/VBoxContainer/TentBtn/TentLbl.text = str(tent)
	$PopHeading/MaxPopLbl.text = "Maximum Population: " + str(maxPops)
	$PopHeading/CurrentPopLbl.text = "Current Population: " + str(curPops)
#--CLICKER FUNCTIONS-------------

func _on_food_btn_pressed():
	food += 1
	$FoodBtn/FoodLbl.text = str(food)
	rng = randi_range(1, 14)
	if (rng == 3):
		skins += 1
		$SpecialResLbl/Skinslbl.text = "Skins: " + str(skins)

func _on_wood_btn_pressed():
	wood += 1
	$WoodBtn/WoodLbl.text = str(wood)
	rng = randi_range(1,14)
	if (rng == 4):
		herbs += 1
		$SpecialResLbl/HerbsLbl.text = "Herbs: " + str(herbs)


func _on_stone_btn_pressed():
	stone += 1
	$StoneBtn/StoneLbl.text = str(stone)
	rng = randi_range(1, 14)
	if (rng == 5):
		ores += 1
		$SpecialResLbl/OresLbl.text = "Ores: " + str(ores)


func _on_create_worker_btn_pressed():
	if (food >= 20) and (maxPops > curPops) and (maxPops > 0):
		curPops += 1
		food -= 20
		idleWorkers += 1
		print(curPops)
		$FoodBtn/FoodLbl.text = str(food)
	else:
		pass

func _on_tent_btn_pressed():
	if (skins >= 2) and (wood >= 2):
		tent += 1
		skins -= 2
		wood -= 2
		freeLand -= 1
		$Background/FreeLandLbl.text = "Free Land: " + str(freeLand)
		$WoodBtn/WoodLbl.text = str(wood)
		$SpecialResLbl/Skinslbl.text = str(skins)
		$TabContainer/Buildings/VBoxContainer/TentBtn/TentLbl.text = str(tent)


func _on_farmer_pos_1_pressed():
	if (idleWorkers >= 1):
		idleWorkers -= 1
		farmers += 1
		$FarmerLbl.text = "Farmers: " + str(farmers)
		$CreateWorkerBtn/IdleWorkerLbl.text = "Idle Workers: " + str(idleWorkers)


func Calculate():
	var consume
	if (farmers > 0):
		food += (farmers * baseGathering)
		consume = "forage"
		SpecialResourceGather(consume)
		$FoodBtn/FoodLbl.text = str(food)
	if (woodcutters > 0):
		consume = "forestry"
		SpecialResourceGather(consume)
		wood += (woodcutters * baseGathering)
		$WoodBtn/WoodLbl.text = str(wood)
	if (miners > 0):
		consume = "mining"
		SpecialResourceGather(consume)
		stone += 1
		$StoneBtn/StoneLbl.text = str(stone)
	if (curPops > 0):
		food -= (miners + woodcutters) * 0.1
	$CreateWorkerBtn/IdleWorkerLbl.text = "Idle Workers: " + str(idleWorkers)
	print(food)


func SpecialResourceGather(type):
	rng = randi_range(1, 14)
	if (type == "forage"):
		$FoodBtn/FoodLbl.text = str(food)
		if (rng == 3):
			skins += 1
			$SpecialResLbl/Skinslbl.text = "Skins: " + str(skins)
	if (type == "forestry"):
		$WoodBtn/WoodLbl.text = str(wood)
		if (rng == 5):
			herbs += 1
			$SpecialResLbl/HerbsLbl.text = "Herbs: " + str(herbs)
	if (type == "mining"):
		$StoneBtn/StoneLbl.text = str(stone)
		if (rng == 11):
			ores += 1
			$SpecialResLbl/OresLbl.text = "Ores: " + str(ores)

func _on_farmer_neg_1_pressed():
	if (farmers >= 1):
		idleWorkers += 1
		farmers -= 1
		$FarmerLbl.text = "Farmers: " + str(farmers)
		$CreateWorkerBtn/IdleWorkerLbl.text = "Idle Workers: " + str(idleWorkers)

func _on_woodcutter_pos_pressed() -> void:
	if (idleWorkers >= 1):
		idleWorkers -= 1
		woodcutters += 1
		$WoodcutterLbl.text = "Woodcutters: " + str(woodcutters)
		$CreateWorkerBtn/IdleWorkerLbl.text = "Idle Workers: " + str(idleWorkers)


func _on_woodcutter_neg_pressed() -> void:
	if (woodcutters >= 1):
		idleWorkers += 1
		woodcutters -= 1
		$WoodcutterLbl.text = "Woodcutters: " + str(woodcutters)
		$CreateWorkerBtn/IdleWorkerLbl.text = "Idle Workers: " + str(idleWorkers)


func _on_miner_pos_pressed() -> void:
	if (idleWorkers >= 1):
		idleWorkers -= 1
		miners += 1
		$MinerLbl.text = "Miners: " + str(miners)
		$CreateWorkerBtn/IdleWorkerLbl.text = "Idle Workers: " + str(idleWorkers)


func _on_miner_neg_pressed() -> void:
	if (miners >= 1):
		idleWorkers += 1
		miners -= 1
		$MinerLbl.text = "Miners: " + str(miners)
		$CreateWorkerBtn/IdleWorkerLbl.text = "Idle Workers: " + str(idleWorkers)
