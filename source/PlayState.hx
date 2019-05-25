package;

import flixel.FlxG;
import flixel.FlxState;

class PlayState extends FlxState {
	override public function create():Void {
		super.create();
		add(new Paddel(30, 30, "W", "S"));
		add(new Paddel(FlxG.width - 40, FlxG.height - 130, "UP", "DOWN"));
		add(new Ball(FlxG.width / 2, FlxG.height / 2));
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
	}
}
