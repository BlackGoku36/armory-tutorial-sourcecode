package arm;

import iron.object.Object;
import iron.math.Vec4;
import iron.Scene;

class HaxeScript extends iron.Trait {
	var haxeCube:Object;
	public function new() {
		super();

		notifyOnInit(function() {
			haxeCube = Scene.active.getChild("Haxe");
		});

		notifyOnUpdate(function() {
			haxeCube.transform.rotate(new Vec4(0.0, 0.0, 1.0), 0.01);
		});
	}
}