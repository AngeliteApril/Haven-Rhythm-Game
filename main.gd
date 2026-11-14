extends Node2D

var down : bool = false
var up : bool = false
var left : bool = false
var right : bool = false
@onready var area_2d: Area2D = $Detector/Area2D
@onready var arrow_generator: Node2D = $ArrowGenerator
@onready var arrow_generator_up: Node2D = $ArrowGeneratorUp
@onready var left_target: Node2D = $Detector/LeftTarget
@onready var down_target: Node2D = $Detector/DownTarget
@onready var up_target: Node2D = $Detector/UpTarget
@onready var right_target: Node2D = $Detector/RightTarget
@onready var miss_zone: Area2D = $Detector/Area2D2

signal hit
signal miss

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_down"):
		down = true
	elif event.is_action_released("ui_down"):
		down = false

	if event.is_action_pressed("ui_up"):
		up = true
	elif event.is_action_released("ui_up"):
		up = false

	if event.is_action_pressed("ui_left"):
		left = true
	elif event.is_action_released("ui_left"):
		left = false

	if event.is_action_pressed("ui_right"):
		right = true
	elif event.is_action_released("ui_right"):
		right = false

	if event.is_action_pressed("ui_test_up"):
		arrow_generator_up.make_arrow()
	if event.is_action_pressed("ui_test_down"):
		arrow_generator.make_arrow()
		
func _process(_delta: float) -> void:
	for x in area_2d.get_overlapping_areas():
		if down == true and x.name.contains("Down"):
			down_target.animation_player.play("Hit")
			hit.emit()
			x.queue_free()
			down = false
		if up == true and x.name.contains("Up"):
			up_target.animation_player.play("Hit")
			hit.emit()
			x.queue_free()
			up = false
		if left == true and x.name.contains("Left"):
			left_target.animation_player.play("Hit")
			hit.emit()
			x.queue_free()
			left = false
		if right == true and x.name.contains("Right"):
			right_target.animation_player.play("Hit")
			hit.emit()
			x.queue_free()
			right = false
			
func _ready() -> void:
	miss_zone.area_entered.connect(_on_miss_zone_area_entered)
	
func _on_miss_zone_area_entered(area: Area2D) -> void:
	miss.emit()
	area.queue_free()
