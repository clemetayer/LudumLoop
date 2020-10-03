extends Polygon2D

var dialog = []

var page = 0 #used to handle the pages for the RichTextLabel
var StartDialog = false
var RTL;

# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide()
	RTL = get_node("RichTextLabel")

func toBBCode(dialogPage):
	var retStr = str("[color=white]",dialogPage,"[/color]")
	return retStr

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(StartDialog):
		if(Input.is_action_pressed("ui_action")):
			if (RTL.get_visible_characters() > RTL.get_total_character_count()): 
					if page < len(dialog)-1:
						page += 1
						RTL.set_visible_characters(0)
						RTL.set_bbcode(dialog[page])
					elif page >= len(dialog)-1:
						RTL.set_visible_characters(0)
						page = 0
						self.hide()
						StartDialog = false

func StartDialog():
	if(StartDialog == false):
		StartDialog = true
		page = 0
		self.show()
		RTL.set_visible_characters(0)
		RTL.set_bbcode(dialog[page])
		

func _on_Timer_timeout():
	RTL.set_visible_characters(RTL.get_visible_characters()+1)
