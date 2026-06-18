@tool
extends EditorPlugin

var csharp_plugin: EditorPlugin

func _enter_tree():
	var script = load("res://addons/BuildOnChangeOnly/BuildOnChangeOnly.cs")
	csharp_plugin = script.new()
	add_child(csharp_plugin)
	csharp_plugin.Start()

func _exit_tree() -> void:
	csharp_plugin.End()

func Build():
	csharp_plugin.End()
	remove_child(csharp_plugin)
	# Press the "Build Project (Alt + B)" button.(or well, call the method that pressing it calls)
	var plugins = get_parent().get_children()
	for plugin in plugins:
		if plugin.has_method("BuildProjectPressed"):
			plugin.BuildProjectPressed()
			break
	var script = load("res://addons/BuildOnChangeOnly/BuildOnChangeOnly.cs")
	csharp_plugin = script.new()
	add_child(csharp_plugin)
	csharp_plugin.call_deferred("Start");
