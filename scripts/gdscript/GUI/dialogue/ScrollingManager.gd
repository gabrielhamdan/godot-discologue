extends ScrollContainer

onready var scrollbar = self.get_v_scrollbar();
onready var historyRows = get_parent().get_node("%HistoryRows");
var scrollOffset := 0;
var scrollbarLength := 0;
var lastRectSize := 0;
var totalRectSize := 0;
var rectPositions := [];
var rectPosition := 0;
var shouldUpdateScrollbar := false;
var scrollingVelocity := 0;
export var minScrollingVelocity := 100;
export var acceleration := 0.005;

func _process(delta: float) -> void:
	updateScrollbar(delta);

func handleAutoScrolling() -> void:
	yield(get_tree(), "idle_frame");
	rectPosition = rectPositions[0];
	scrollingVelocity = rectPosition;
	shouldUpdateScrollbar = true;

func updateScrollbar(delta: float) -> void:
	if shouldUpdateScrollbar:
		if totalRectSize >= scrollbar.page:
			setScrollbarValue(delta, (scrollbar.max_value - scrollbar.value), (rectPosition - scrollbar.value), scrollbar.value >= rectPosition || scrollbar.value >= scrollbar.max_value - scrollbar.page, rectPosition);
		else:
			setScrollbarValue(delta, (scrollbar.max_value - scrollbar.value), (scrollbar.max_value - scrollbar.value), scrollbar.value >= scrollbar.max_value - scrollbar.page, scrollbar.max_value);

func setScrollbarValue(delta: float, initialVelocity: float, finalVelocity: float, shouldHaltUpdate: bool, scrollbarValue: float) -> void:
	scrollingVelocity = lerp(initialVelocity * 0.4, finalVelocity * 0.05, acceleration * delta);
	if scrollingVelocity <= minScrollingVelocity:
		scrollingVelocity = minScrollingVelocity;
	scrollbar.value += scrollingVelocity * delta;
	if shouldHaltUpdate:
		scrollbar.value = scrollbarValue
		totalRectSize = 0;
		rectPositions = [];
		shouldUpdateScrollbar = false;

func setScrollOffsetSize(rectSize : int) -> void:
	totalRectSize += rectSize;

func setScrollOffsetPosition(rectPos : Node) -> void:
	rectPositions.append(rectPos.rect_position.y);
