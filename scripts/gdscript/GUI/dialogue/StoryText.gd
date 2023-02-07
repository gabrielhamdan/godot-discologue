extends RichTextLabel

onready var scrollContainer = get_tree().root.get_node("GameScene/GUI/DialogueInterface/TextDisplay/MarginContainer/Rows/StoryTextContainer/MarginContainer/ScrollContainer");
onready var buttonRows = get_tree().root.get_node("GameScene/GUI/DialogueInterface/TextDisplay/MarginContainer/Rows/StoryTextContainer/MarginContainer/ScrollContainer/VBoxContainer/ButtonRows");

var shouldFadeColor setget setShouldFadeColor;
var t := 0.0;

func _ready() -> void:
	shouldFadeColor = false;

func _process(delta: float) -> void:
	fadeText(delta);

func _on_StoryText_tree_entered() -> void:
	yield(get_tree(), "idle_frame");
	scrollContainer.setScrollOffsetPosition(self);
	buttonRows.setNewTextNodes(self);

func fadeText(delta: float) -> void:
	if shouldFadeColor:
		t += delta;
		if t >= 0.8:
			shouldFadeColor = false;
			return;
		self.set_modulate(Color(0.886275, 0.87451, 0.87451).linear_interpolate(Color(0.54902, 0.513726, 0.513726), t));

func setShouldFadeColor(value: bool) -> void:
	shouldFadeColor = value;
