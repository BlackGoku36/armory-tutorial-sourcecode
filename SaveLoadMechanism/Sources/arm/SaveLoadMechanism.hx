package arm;

import armory.trait.internal.CanvasScript;// 1
import armory.system.Event;
import iron.Scene;
import iron.math.Vec4;
import iron.system.Input;
import iron.data.Data;

typedef Cube = { loc : Vec4, rot : Vec4 }

class SaveLoadMechanism extends iron.Trait {

	var kb = Input.getKeyboard();

	var saveFile = "save_game.json";

	var canvas:CanvasScript;// 1

	var isButtonsHidden:Bool;// 2

	public function new() {
		super();

		notifyOnInit(function(){
			canvas = Scene.active.getTrait(CanvasScript);// 1

			hideButtons();
			isButtonsHidden = true;
			Event.add("save_btn", save);
			Event.add("load_btn", load);
		});

		notifyOnUpdate(function (){// 3
			// 4
			if (kb.started("m")){
				if (isButtonsHidden){
					showButtons();
				}else{
					hideButtons();
				}
			}
		});

	}
	public function save(){
		var cube = Scene.active.getChild("Cube");
		var cubeLoc = cube.transform.loc;
		var cubeRot = new Vec4(cube.transform.rot.x, cube.transform.rot.y, cube.transform.rot.z);
		#if kha_krom
		var saveData: Cube = {loc: cubeLoc, rot: cubeRot};
		var saveDataJSON = haxe.Json.stringify(saveData);

		var path = Krom.getFilesLocation() + "/../../../" + "/Bundled/save_game.json";

		var bytes = haxe.io.Bytes.ofString(saveDataJSON);
		Krom.fileSaveBytes(path, bytes.getData());
		trace("Saved!");
		#end
	}

	public function load() {
		var cube = Scene.active.getChild("Cube");
		Data.getBlob(saveFile, function(b:kha.Blob) {
			// Get string from loaded bytes
			var string = b.toString();

			// Get json from string
			var json = haxe.Json.parse(string);
			cube.transform.loc = json.loc;
			cube.transform.setRotation(json.rot.x, json.rot.y, json.rot.z);
			cube.transform.buildMatrix();
		});
	}
	// 5
	public function hideButtons() {
		canvas.getElement("save_btn").visible = false;
		canvas.getElement("load_btn").visible = false;
		isButtonsHidden = true;
	}
	// 5
	public function showButtons() {
		canvas.getElement("save_btn").visible = true;
		canvas.getElement("load_btn").visible = true;
		isButtonsHidden = false;
	}
}
