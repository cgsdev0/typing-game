extends RichTextLabel



var submitted = false
var goal
var typed = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	text = "[color=darkgray]" + goal + "[/color]"
	pass # Replace with function body.

func _input(event):
	if submitted:
		return
	if event is InputEventKey and event.is_pressed():
		var key_text = event.as_text().to_lower()
		match key_text:
			"backspace":
				typed = typed.substr(0, max(0, typed.length() - 1))
			"space":
				typed += " "
			"enter":
				submit()
			"period":
				typed += "."
			"comma":
				typed += ","
			"shift+comma":
				typed += "<"
			"shift+period":
				typed += ">"
			"minus":
				typed += "-"
			"shift+minus":
				typed += "_"
			"equal":
				typed += "="
			"shift+equal":
				typed += "+"
			"slash":
				typed += "/"
			"shift+slash":
				typed += "?"
			"backslash":
				typed += "\\"
			"shift+backslash":
				typed += "|"
			"shift+1":
				typed += "!"
			"shift+2":
				typed += "@"
			"shift+3":
				typed += "#"
			"shift+4":
				typed += "$"
			"shift+5":
				typed += "%"
			"shift+6":
				typed += "^"
			"shift+7":
				typed += "&"
			"shift+8":
				typed += "*"
			"shift+9":
				typed += "("
			"shift+0":
				typed += ")"
			"bracketleft":
				typed += "["
			"bracketright":
				typed += "]"
			"shift+bracketleft":
				typed += "{"
			"shift+bracketright":
				typed += "}"
			"semicolon":
				typed += ";"
			"shift+semicolon":
				typed += ":"
			"apostrophe":
				typed += "'"
			"shift+apostrophe":
				typed += '"'
		
			_:
				if key_text.begins_with("shift+"):
					key_text = key_text.split("shift+")[1].to_upper()
				if key_text.length() == 1:
					typed += key_text
				else:
					print(key_text)
					
func submit():
	submitted = true
	var builder = "[color=white]"
	var oops = 0
	var nice = 0
	for i in range(typed.length()):
		var t = typed[i]
		var g = goal[min(i, max(0, goal.length() - 1))]
		if t != g:
			builder += "[color=red][u]"
			builder += t
			builder += "[/u][/color]"
			oops += 1
		else:
			nice += 1
			builder += t
	builder += "[/color][color=red][u]"
	var forgot = goal.substr(min(typed.length(), goal.length()))
	builder += forgot
	oops += forgot.length()
	builder += "[/u][/color]"
	text = "$ " + builder
	modulate.a = 0.47
	get_parent().submit(oops, nice)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if submitted:
		return
	var builder = "[color=white]"
	for i in range(typed.length()):
		var t = typed[i]
		var g = goal[min(i, max(0, goal.length() - 1))]
		if t != g:
			builder += "[color=red][u]"
			builder += t
			builder += "[/u][/color]"
		else:
			builder += t
	builder += "[/color][color=darkgray]"
	builder += goal.substr(min(typed.length(), goal.length()))
	builder += "[/color]"
	text = "$ " + builder
