package;

import flixel.util.FlxTimer;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.FlxG;
import flixel.FlxState;

enum GameState {
	pause;
	play;
}

class PlayState extends FlxState {
	var paddels = new FlxGroup();
	var ball:Ball;
	var player1Score = 0;
	var player2Score = 0;
	var maxScore = 5;
	var scoreText:FlxText;
	var winText:FlxText;
	var instructionText:FlxText;
	var state = GameState.pause;

	override public function create():Void {
		super.create();

		paddels.add(new Paddel(30, 30, "W", "S"));
		paddels.add(new Paddel(FlxG.width - 40, FlxG.height - 130, "UP", "DOWN"));
		add(paddels);

		ball = new Ball(FlxG.width / 2, FlxG.height / 2);
		ball.resetPosition();
		add(ball);

		// Add score
		scoreText = new FlxText(0, 0, FlxG.width, '0 | 0');
		scoreText.setFormat(null, 20, FlxColor.GREEN, FlxTextAlign.CENTER);
		add(scoreText);

		instructionText = new FlxText(0, FlxG.height * 0.4, FlxG.width, '0 | 0');
		instructionText.setFormat(null, 20, FlxColor.GREEN, FlxTextAlign.CENTER);
		instructionText.text = 'Press SPACE to start';
		add(instructionText);

		winText = new FlxText(0, FlxG.height * 0.3, FlxG.width, 'Player 1 win');
		winText.setFormat(null, 24, FlxColor.GREEN, FlxTextAlign.CENTER);
		add(winText);
		winText.visible = false;
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);

		if (state == GameState.pause && FlxG.keys.anyPressed(['SPACE'])) {
			state = GameState.play;
			startGame();
		}

		FlxG.collide(paddels, ball, function(paddel:FlxSprite, ball:FlxSprite) {
			ball.velocity.y = (ball.getMidpoint().y - paddel.getMidpoint().y) * 1.2;
			FlxG.sound.play(AssetPaths.pop__wav);
		});

		if (ball.x < 0) {
			player2Score++;
			updateScore();
		} else if (ball.x > FlxG.width) {
			player1Score++;
			updateScore();
		}
	}

	function updateScore() {
		if (player1Score == maxScore || player2Score == maxScore) {
			var winner = player1Score > player2Score ? "1" : "2";
			winText.text = 'Player ${winner} wins';
			winText.visible = true;
			instructionText.visible = true;
			ball.resetPosition();
      state = GameState.pause;
		} else {
			ball.resetPosition();
			new FlxTimer().start(2, (timer) -> {
				ball.restart();
			});
		}
		scoreText.text = player1Score + ' | ' + player2Score;
		FlxG.sound.play(AssetPaths.win__wav);
		FlxG.camera.shake(0.01);
		FlxG.camera.flash(FlxColor.fromHSB(FlxG.random.int(1, 360), 0.7, 0.7));
	}

	function startGame() {
		ball.restart();
		player1Score = player2Score = 0;

		winText.visible = false;
		instructionText.visible = false;
	}
}
