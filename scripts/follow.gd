extends Node2D

const Rules = preload("res://scripts/rules.gd")
var rules = Rules.new()

func _ready() -> void:
	$SheetLens.make_current()
	rules.crate = rules.second_layout()
	_place()

func _unhandled_input(event: InputEvent) -> void:
	var step := Vector2i.ZERO
	if event.is_action_pressed("stride_east"):
		step = Vector2i(1, 0)
	elif event.is_action_pressed("stride_west"):
		step = Vector2i(-1, 0)
	elif event.is_action_pressed("stride_north"):
		step = Vector2i(0, -1)
	elif event.is_action_pressed("stride_south"):
		step = Vector2i(0, 1)
	elif event.is_action_pressed("leap"):
		if rules.try_pull() == "rejected":
			rules.undo_shove()
	if step != Vector2i.ZERO:
		rules.try_shove(step)
	_place()

func _place() -> void:
	$SecondCrate.offset_left = rules.crate.x * 52 + 4
	$SecondCrate.offset_top = rules.crate.y * 52 + 4
	$SecondCrate.offset_right = $SecondCrate.offset_left + 40
	$SecondCrate.offset_bottom = $SecondCrate.offset_top + 40
