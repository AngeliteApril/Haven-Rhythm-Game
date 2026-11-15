
extends ScrollContainer

@onready var content = $VBoxContainer
@onready var songTemplate = $SongTemplate

# Using DataHandler to Retrieve Song Data
# Creating Clones from them and Displaying the Song Data
# If Chosen Song Attach an Event Listner To Listen for Enter Input
#Change Scene if Pressed Enter Key

func _ready():
	get_v_scroll_bar().value_changed.connect(_on_scroll)

func _on_scroll(scrollPos):
	print("Scroll position:", scrollPos)
	# SCROLL LOGIC USE scrollPos
	
