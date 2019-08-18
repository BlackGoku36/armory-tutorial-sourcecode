package arm;

import iron.math.Vec4;
import iron.system.Input;
import kha.math.Random;

class CubeController extends iron.Trait {
	var kb = Input.getKeyboard();
	public function new() {
		super();

		notifyOnUpdate(function() {
			if(kb.down("up")) object.transform.translate(-0.2, 0.0, 0.0);
			else if (kb.down("down")) object.transform.translate(0.2, 0.0, 0.0);
			else if (kb.down("left")) object.transform.translate(0.0, -0.2, 0.0);
			else if (kb.down("right")) object.transform.translate(0.0, 0.2, 0.0);
			else if (kb.down("r")) object.transform.rotate(new Vec4(Math.random(), Math.random(), Math.random()), 0.1);
		});
	}
}
