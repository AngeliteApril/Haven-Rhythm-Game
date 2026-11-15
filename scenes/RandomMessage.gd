extends Label

var messages = [
    "You gotta Get Back Up!",
    "Bounce right back knuckle head",
    "Cmon man we gotta get goin",
    "Dude whats wrong man lets get back into it",
    "Its fine u failed but we can do this",
]

func _ready() -> void:
    randomize()
    text = messages.pick_random()