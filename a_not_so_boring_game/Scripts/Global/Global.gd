extends Node

const SAVE_PATH = "user://game-data.json"

func save(data):
	var file = File.new()
	file.open(Global.SAVE_PATH, File.WRITE)
	file.store_string(to_json(data))
	file.close()

func loadSave():
	var file = File.new()
	if file.file_exists(Global.SAVE_PATH):
		file.open(Global.SAVE_PATH, File.READ)
		var data = parse_json(file.get_as_text())
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			return(data)
		else:
			printerr("Corrupted data!")
			return {"cheated" : false}
	else:
		printerr("No saved data!")
		return {"cheated" : false}
