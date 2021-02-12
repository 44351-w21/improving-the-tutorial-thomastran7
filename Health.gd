extends Control

var hearts = 3 setget set_hearts
var max_hearts = 3 setget set_max_hearts

onready var fullheart = $FullHeart
onready var emptyheart = $EmptyHeart

func set_hearts(value):
	hearts = clamp(value, 0, max_hearts)
	if fullheart != null:
		fullheart.rect_size.x = hearts * 28
	
func set_max_hearts(value):
	max_hearts = max(value, 1)
	self.hearts = min(hearts, max_hearts)
	if emptyheart != null:
		emptyheart.rect_size.x = max_hearts * 28
	
func _ready():
	self.max_hearts = Stats.max_health
	self.hearts = Stats.health
	Stats.connect("health_changed", self, "set_hearts")
	Stats.connect("max_health_changed", self, "set_max_hearts")

 
