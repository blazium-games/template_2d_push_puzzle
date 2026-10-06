extends Node2D

const Rules = preload("res://scripts/rules.gd")
var rules = Rules.new()

@onready var crate_mark: ColorRect = $CrateMark

func _ready() -> void:
	$SheetLens.make_current()

func _unhandled_input(event: InputEvent) -> void:
	var step := Vector2i.ZERO
	if event.is_action_pressed("stride_west"):
		step = Vector2i(-1, 0)
	elif event.is_action_pressed("stride_east"):
		step = Vector2i(1, 0)
	elif event.is_action_pressed("stride_north"):
		step = Vector2i(0, -1)
	elif event.is_action_pressed("stride_south"):
		step = Vector2i(0, 1)
	if event.is_action_pressed("leap"):
		rules.undo_shove()
	if step != Vector2i.ZERO:
		rules.try_shove(step)
	if rules.may_board_two():
		_go("res://scenes/board_two.tscn")
		crate_mark.offset_left = rules.crate.x * 52 + 4
		crate_mark.offset_top = rules.crate.y * 52 + 4
		crate_mark.offset_right = crate_mark.offset_left + 40
		crate_mark.offset_bottom = crate_mark.offset_top + 40

func _go(next_path: String) -> void:
	get_tree().change_scene_to_file(next_path)
