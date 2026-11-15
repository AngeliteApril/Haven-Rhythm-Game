extends ScrollContainer

@onready var songsmenu = get_parent().get_parent().get_parent()
@onready var songtemplate = songsmenu.get_node("SongTemplate")
@onready var songdata = DataHandler.get_songdata()
@onready var songsContain = get_node("SongsContain")
@onready var scrollDetect = songsmenu.get_node("ScrollDetect")

var songsTable = []
var previousFocusedSong = null

var scrollTween: Tween


func _ready() -> void:
	for song in songdata.keys():
		var songdatatable = songdata[song]

		var songSelectFrame = songtemplate.duplicate()
		songsContain.add_child(songSelectFrame)

		songSelectFrame.visible = true
		songSelectFrame.name = str(song)

		songSelectFrame.get_node("SongDifficulty").text = songdatatable.difficulty
		songSelectFrame.get_node("SongTitle").text = songdatatable.songtitle

		songsTable.append(songSelectFrame)

	songtemplate.queue_free()

	
	await get_tree().process_frame

	
	_create_barriers()

	
	await get_tree().process_frame

	
	scroll_vertical = 50


func _create_barriers() -> void:
	if songsTable.is_empty():
		return

	var firstSong = songsTable[0]
	var lastSong = songsTable[-1]

	var detectorCenter = scrollDetect.global_position.y + scrollDetect.size.y / 2.0
	var viewportTop = global_position.y
	var viewportBottom = global_position.y + size.y

	var topSpace = detectorCenter - viewportTop - firstSong.size.y / 2.0
	var bottomSpace = viewportBottom - detectorCenter - lastSong.size.y / 2.0

	var topBarrier = Control.new()
	topBarrier.name = "TopBarrier"
	topBarrier.custom_minimum_size.y = maxf(0, topSpace)
	songsContain.add_child(topBarrier)
	songsContain.move_child(topBarrier, 0)

	var bottomBarrier = Control.new()
	bottomBarrier.name = "BottomBarrier"
	bottomBarrier.custom_minimum_size.y = maxf(0, bottomSpace)
	songsContain.add_child(bottomBarrier)


func _scroll_tween(amount: int) -> void:
	if scrollTween:
		scrollTween.kill()

	var target_position = clampf(
		scroll_vertical + amount,
		0,
		get_v_scroll_bar().max_value
	)

	scrollTween = create_tween()

	scrollTween.tween_property(
		self,
		"scroll_vertical",
		target_position,
		0.25
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)


func _process(_delta: float) -> void:
	var targetSong = null

	var overlapping = scrollDetect.get_overlapping_songs(songsTable)

	if overlapping.size() > 0:
		targetSong = overlapping[0]

	if targetSong != previousFocusedSong:
		if previousFocusedSong != null:
			_apply_tween(previousFocusedSong, Vector2(1.0, 1.0))

		if targetSong != null:
			_apply_tween(targetSong, Vector2(1.2, 1.2))

		previousFocusedSong = targetSong

	set_process_input(targetSong != null)


func _apply_tween(target: Control, new_size: Vector2) -> void:
	if target == null:
		return

	var tween = create_tween()

	tween.tween_property(
		target,
		"scale",
		new_size,
		0.2
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_down"):
		_scroll_tween(75)

	elif event.is_action_pressed("ui_up"):
		_scroll_tween(-75)

	elif event.is_action_pressed("ui_enter"):
		if previousFocusedSong != null:
			_select_song(previousFocusedSong.name)


func _select_song(song_name: String) -> void:
	match song_name:
		"song1":
			get_tree().change_scene_to_file("res://scenes/Song1.tscn")

		"song2":
			get_tree().change_scene_to_file("res://scenes/Song2.tscn")

		"song3":
			get_tree().change_scene_to_file("res://scenes/Song3.tscn")
