package;

import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.FlxSprite;

class Ball extends FlxSprite {
	public function new(x, y) {
		super(x, y);

		makeGraphic(10, 10, FlxColor.WHITE);
		velocity = new FlxPoint(100, 50);
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
	}
}
