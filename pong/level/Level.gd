extends Node

var PlayerScore = 0
var OpponentScore = 0

func _on_LimitLeft_body_entered(body):
	$Ball.position = Vector2(640, 360)
	$Ball.speed = 450
	OpponentScore += 1

func _on_LimitRight_body_entered(body):
	$Ball.position = Vector2(640, 360)
	$Ball.speed = 450
	PlayerScore += 1

func _process(delta):
	$PlayerScore.text = str(PlayerScore)
	$OpponentScore.text = str(OpponentScore)
