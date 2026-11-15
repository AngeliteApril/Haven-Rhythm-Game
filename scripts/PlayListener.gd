extends Control

var entered: bool = false
@onready var pressEnterLabel: Label = $Panel/EnterLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DataHandler.save()
	DataHandler.load()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_enter"):
		get_tree().change_scene_to_file("res://scenes/optionsmenu.tscn")


func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		DataHandler.save()
		get_tree().quit()

	elif what == NOTIFICATION_WM_GO_BACK_REQUEST:
		DataHandler.save()
		get_tree().quit()

	# func _notification(what: int) -> void:
	# if what == NOTIFICATION_WM_CLOSE_REQUEST:
	#     DataHandler.save()
		

	# elif what == NOTIFICATION_WM_GO_BACK_REQUEST:
	#     DataHandler.save()
	#     get_tree().quit()

	# elif what == NOTIFICATION_WM_GO_BACK_REQUEST: DataHandler.save() get_tree().quit()
# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta: float) -> void:
# 	pass
