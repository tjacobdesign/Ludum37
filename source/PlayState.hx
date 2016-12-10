package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

import entities.Player;
import controllers.PlayerController;

class PlayState extends FlxState
{
	private var playerController:PlayerController;
	private var player:Player;

	override public function create():Void
	{
		super.create();

		this.player = new Player();
		this.player.state = this;
		add(player);

		playerController = new PlayerController(this.player);
	}

	override public function update(elapsed:Float):Void
	{
		this.playerController.update();

		super.update(elapsed);
	}
}