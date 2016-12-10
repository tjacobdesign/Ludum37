package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;

import flixel.group.FlxGroup;

import entities.Entity;
import entities.Weapon;
import entities.Bullet;

class Player extends Entity
{
	private static inline var SPRITE_HEIGHT:Int = 200;
	private static inline var SPRITE_WIDTH:Int = 171;

	public var playerWeapon:Weapon;

	public function new(playState:PlayState, ?X:Float=0, ?Y:Float=0)
	{
		state = playState;
		super(X, Y);
		this.health = 10;
		loadGraphic(AssetPaths.gnome__png, true, SPRITE_WIDTH, SPRITE_HEIGHT);

		animation.add('idle', [0,1,2,3,4,5,6,7,8,9,10], 8);
		animation.add('walk', [12,13,14,15,16,17,18,19,20,21,22], 4);
		animation.play('idle');

		scale.set(0.5, 0.5);

		playerWeapon = new Weapon();
		playerWeapon.state = state;
		add(playerWeapon);
		state.add(playerWeapon.bulletArray);
	}

	public function setMoving(moving:Bool) {
		this.moving = moving;
	}

	public function setMoveAngle(moveAngle:Float) {
		this.moveAngle = moveAngle;
	}

	public function useWeapon(angle:Float)
	{
		playerWeapon.fire(angle);
	}

	override public function update(delta:Float)
	{
		if (this.moving) {
			velocity.set(this.moveSpeed, 0);
			velocity.rotate(FlxPoint.weak(0, 0), this.moveAngle);
		} else {
			velocity.set(0, 0);
		}

		super.update(delta);
	}
}