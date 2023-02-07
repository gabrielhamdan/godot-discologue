extends VBoxContainer

var newTextNodes setget setNewTextNodes, getNewTextNodes

func _ready() -> void:
	newTextNodes = [];

func setNewTextNodes(textNode: Node) -> void:
	if textNode != null:
		newTextNodes.append(textNode.get_path());
	else:
		newTextNodes = [];

func getNewTextNodes() -> String:
	return newTextNodes;





