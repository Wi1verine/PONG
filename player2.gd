extends CharacterBody2D

var speed = 10

func _physics_process(_delta: float):
	if Input.is_action_pressed("2up") && position.y >= 32:
		position.y -= speed
	if Input.is_action_pressed("2down") && position.y <= 640 - 32:
		position.y += speed
