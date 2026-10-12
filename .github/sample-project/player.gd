extends MeshInstance3D
## Personagem do jogo de exemplo: anda com as setas e gira devagar.

@export var speed := 4.0
@export var spin := 1.2

var score := 0


func _process(delta: float) -> void:
	var input := Vector3(
		Input.get_axis("ui_left", "ui_right"),
		0.0,
		Input.get_axis("ui_up", "ui_down"),
	)
	position += input * speed * delta
	rotate_y(spin * delta)


func collect(points: int) -> void:
	score += points
	print("Pontos: ", score)
