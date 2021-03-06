package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import flixel.system.FlxAssets.FlxGraphicAsset;

class LevelState extends FlxState
{
	public var width:Int = 1200;
	public var height:Int = 950;
	public function new(state:PlayState):Void
	{
		var level = new FlxSprite(0, 0, AssetPaths.floor__png);
		level.scale.set(0.4, 0.4);
		level.origin.set(0, 0);

		state.add(level);
		// state.add(doors);

		super();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
