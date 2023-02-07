extends PanelContainer

const STORY_TEXT_SCENE = preload("res://scenes/GUI/dialogue/StoryText.tscn");
onready var historyRows = get_node("%HistoryRows");

const CHOICE_BUTTON_SCENE = preload("res://scenes/GUI/dialogue/ChoiceButton.tscn");
onready var buttonRows = get_node("%ButtonRows");

onready var scrollContainer = get_node("%ScrollContainer");

var newTextAppended := [];

func _ready() -> void:
	get_node("/root/GameScene/InkManager").GetStoryChunk(null);

func printStory(storyText : String) -> void:
	if storyText.strip_edges(true, true).length() > 0:
		var storyTextInstance = STORY_TEXT_SCENE.instance();
		storyTextInstance.bbcode_text = storyText;
		historyRows.add_child(storyTextInstance);
		scrollContainer.setScrollOffsetSize(storyTextInstance.rect_size.y);
		newTextAppended.append(storyTextInstance);

func instaceChoiceButtons(choiceText : String, index : int) -> void:
	var btnInstance = CHOICE_BUTTON_SCENE.instance();
	btnInstance.choiceIndex = index;
	btnInstance.text = choiceText;
	buttonRows.add_child(btnInstance);
	scrollContainer.setScrollOffsetSize(btnInstance.rect_size.y);

func refreshChoiceButtons() -> void:
	if buttonRows.get_child_count() > 0:
		for i in buttonRows.get_children():
			var node = get_path_to(i);
			get_node(node).queue_free();
