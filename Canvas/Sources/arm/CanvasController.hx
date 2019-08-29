package arm;

import kha.Color;
import zui.Canvas.TElement;
import iron.Scene;
import armory.trait.internal.CanvasScript;
import armory.system.Event;

class CanvasController extends iron.Trait {

	var canvas:CanvasScript;
	var text:TElement;

	public function new() {
		super();

		notifyOnInit(function() {
			canvas = Scene.active.getTrait(CanvasScript);
			text = canvas.getElement("txt");
			Event.add("apply_btn", applyCanvas);
		});
	}

	public function applyCanvas() {
		set_rgb();
		set_visibility();
		set_input_txt();
		set_rotation();
	}

	public function set_rgb() {
		var r = canvas.getHandle("slider_r").value;
		var g = canvas.getHandle("slider_g").value;
		var b = canvas.getHandle("slider_b").value;
		text.color = Color.fromFloats(r, g, b);
	}
	
	public function set_visibility() {
		var is_selected = canvas.getHandle("visibility").selected;
		if (!is_selected){
			text.visible = false;
		}else{
			text.visible = true;
		}
	}

	public function set_input_txt() {
		var input_txt = canvas.getHandle("input_txt").text;
		var caseSensitivity = canvas.getHandle("dd_case").position;
		if (caseSensitivity == 1){
			text.text = input_txt.toUpperCase();
		}else if (caseSensitivity == 2){
			text.text = input_txt.toLowerCase();
		}else{
			text.text = input_txt;
		}
	}

	public function set_rotation(){
		var rotate = canvas.getHandle("rotate").position;
		if (rotate == 0){
			text.rotation = 0;
		}else if (rotate == 1){
			text.rotation = 90*3.14/180;
		}else if (rotate == 2){
			text.rotation = 180*3.14/180;
		}
	}
}