extends RefCounted

var crate := Vector2i(1, 1)
var plate := Vector2i(3, 1)
var blockers: Array[Vector2i] = [Vector2i(0, 1), Vector2i(2, 2)]

func try_pull() -> String:
	return "rejected"

func try_shove(step: Vector2i) -> String:
	var nxt := crate + step
	if nxt.x < 0 or nxt.y < 0 or nxt.x > 3 or nxt.y > 3:
		return "blocked"
	if nxt in blockers:
		return "blocked"
	prior = crate
	crate = nxt
	shoved = true
	if crate == plate:
		return "solved"
	return "moved"

func reset_board() -> void:
	crate = Vector2i(1, 1)

var shoved := false
var prior := Vector2i(1, 1)

func undo_shove() -> String:
	if not shoved:
		return "none"
	crate = prior
	shoved = false
	return "undone"

func may_board_two() -> bool:
	return crate == plate

func second_layout() -> Vector2i:
	return Vector2i(2, 0)
