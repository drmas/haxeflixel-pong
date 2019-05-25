package;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxSprite;

class Paddel extends FlxSprite {
  var upKey: String;
  var downKey: String;
  public function new (x, y, _upKey:String, _downKey:String) {
    super(x, y);
    upKey = _upKey;
    downKey = _downKey;
    makeGraphic(10, 100, FlxColor.WHITE);
  }

  override function update(elapsed:Float) {
    super.update(elapsed);
    if(FlxG.keys.anyPressed([upKey])) {
      this.y -= 5;
    } else if (FlxG.keys.anyPressed([downKey])) {
      this.y += 5;
    }

    this.y = this.y < 0 ? 0 : this.y;
    this.y = this.y > FlxG.height - 100 ? FlxG.height - 100 : this.y;
  }
}