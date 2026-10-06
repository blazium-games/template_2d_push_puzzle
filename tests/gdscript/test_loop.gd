extends AutoworkTest

const Rules = preload("res://scripts/rules.gd")

func test_push_and_block() -> void:
	var rules = Rules.new()
	assert_eq(rules.try_shove(Vector2i(-1, 0)), "blocked", "wall")
	assert_eq(rules.crate, Vector2i(1, 1), "crate stays")

func test_solve() -> void:
	var rules = Rules.new()
	assert_eq(rules.try_shove(Vector2i(1, 0)), "moved", "one step")
	assert_eq(rules.try_shove(Vector2i(1, 0)), "solved", "on plate")

func test_undo_and_next() -> void:
	var rules = Rules.new()
	assert_eq(rules.undo_shove(), "none", "nothing to undo")
	assert_eq(rules.try_shove(Vector2i(1, 0)), "moved", "shove")
	assert_eq(rules.undo_shove(), "undone", "undo")
	assert_eq(rules.crate, Vector2i(1, 1), "back")
	rules.try_shove(Vector2i(1, 0))
	rules.try_shove(Vector2i(1, 0))
	assert_true(rules.may_board_two(), "solved")
	assert_eq(rules.second_layout(), Vector2i(2, 0), "second crate")
	assert_true(load("res://scenes/board_two.tscn") != null, "board loads")

func test_try_pull() -> void:
	var rules = Rules.new()
	assert_eq(rules.try_pull(), "rejected", "pull rejected")
	assert_eq(rules.try_shove(Vector2i(1, 0)), "moved", "shove stays")
