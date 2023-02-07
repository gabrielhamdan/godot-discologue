extends Button

export(int) var choiceIndex;
onready var inkManager = get_tree().root.get_node("GameScene/InkManager");
onready var dialogueDisplay = get_tree().root.get_node("GameScene/GUI/DialogueInterface/TextDisplay");
onready var scrollContainer = get_tree().root.get_node("GameScene/GUI/DialogueInterface/TextDisplay/MarginContainer/Rows/StoryTextContainer/MarginContainer/ScrollContainer");

onready var newTextNodes = get_parent().getNewTextNodes();

func _on_btn_pressed():
	if (choiceIndex != -1):
		for i in newTextNodes.size():
			get_tree().root.get_node(newTextNodes[i]).setShouldFadeColor(true);
		get_parent().setNewTextNodes(null);
		inkManager.MakeChoice(choiceIndex);
		scrollContainer.handleAutoScrolling();
	else:
		get_tree().root.get_node("GameScene/GUI/DialogueInterface/TextDisplay").queue_free();
