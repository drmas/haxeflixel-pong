package;

import flixel.util.FlxTimer;
import flixel.math.FlxRandom;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.FlxSprite;

class Ball extends FlxSprite {
	public function new(x, y) {
		super(x, y);

		makeGraphic(10, 10, FlxColor.WHITE);
		velocity = new FlxPoint(FlxG.random.sign() * 200, FlxG.random.float(-100, 100));
		elasticity = 1;
	}

	override function update(elapsed:Float) {
		super.update(elapsed);

		if (y < 0) {
			velocity.y *= -1;
		}

		if (y > FlxG.height - 10) {
			velocity.y *= -1;
		}
	}

	public function resetPosition() {
		x = FlxG.width / 2;
		y = FlxG.height / 2;

		velocity.set();
	}

	public function restart() {
		velocity = new FlxPoint(FlxG.random.sign() * 200, FlxG.random.float(-100, 100));
	}
}
