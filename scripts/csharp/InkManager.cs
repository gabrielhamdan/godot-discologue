using Godot;
using System;
using Ink.Runtime;

public class InkManager : Node
{
    private PanelContainer _textDisplay;
    [Export] Resource _jsonFile;
    private Story _inkStory;

    public override void _Ready()
    {
        _textDisplay = GetTree().Root.GetNode("GameScene/GUI/DialogueInterface").GetNode<PanelContainer>("TextDisplay");
//GUI/DialogueDisplay
        ReadJson();
    }

    public void ReadJson()
    {
        Godot.File file = new Godot.File();
        file.Open(_jsonFile.ResourcePath, Godot.File.ModeFlags.Read);
   
        string text = file.GetAsText();

        _inkStory = new Story(text);
    }

    public void GetStoryChunk(string knot)
    {
        string storyText;
        
        if(!string.IsNullOrEmpty(knot))
        {
            _inkStory.ChoosePathString(knot);
        }

        while (_inkStory.canContinue)
        {
            storyText = _inkStory.Continue();
            _textDisplay.Call("printStory", storyText);
            //store storyText in array then send it to printStory instead
        }
            
        _textDisplay.Call("refreshChoiceButtons");

        if(_inkStory.currentChoices.Count > 0)
        {
            for (int i = 0; i < _inkStory.currentChoices.Count; ++i) {
                Choice choice = _inkStory.currentChoices [i];
                _textDisplay.Call("instaceChoiceButtons", choice.text, i);
            }
        } else {
                _textDisplay.Call("instaceChoiceButtons", "END", -1);
        }
    }

    public void MakeChoice(int choiceIndex)
    {
        _inkStory.ChooseChoiceIndex(choiceIndex);
        GetStoryChunk("");
    }
}
