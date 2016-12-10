package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.ui.FlxBar;
import flixel.group.FlxGroup;
import flixel.math.FlxRandom;

import entities.*;
import entities.weapons.*;
import entities.bullets.*;
import controllers.PlayerController;

import Wave;

class PlayState extends FlxState
{
	private var playerController:PlayerController;
	public var player:Player;
	private var level:LevelState;
	private var barriers:Barriers;

	public var enemies:FlxTypedGroup<Entity>;
	public var playerBullets:FlxTypedGroup<Bullet>;
	public var groundWeapons:FlxTypedGroup<Weapon>;
	public var counterSpawners:FlxTypedGroup<CounterSpawner>;

	public var currentWave:Wave;
	public var waveNumber:Int = 0;

	public var spawnTimer:Float = 10;

	override public function create():Void
	{
		level = new LevelState(this);
		enemies = new FlxTypedGroup<Entity>();
		playerBullets = new FlxTypedGroup<Bullet>();
		add(playerBullets);
		groundWeapons = new FlxTypedGroup<Weapon>();
		add(groundWeapons);
		counterSpawners = new FlxTypedGroup<CounterSpawner>();
		add(counterSpawners);
		counterSpawners.add(new CounterSpawner(this, 0,50));
		counterSpawners.add(new CounterSpawner(this, 700,50));

		add(level);

		super.create();

		player = new Player(this, 500, 500);
		add(player);

		var triple = new Triple(500, 600);
		triple.state = this;
		groundWeapons.add(triple);

		currentWave = Wave.getWave(waveNumber);

		playerController = new PlayerController(this.player);

		barriers = new Barriers(this, player);

		FlxG.camera.follow(player, FlxCameraFollowStyle.TOPDOWN);
		FlxG.camera.setScrollBoundsRect(0, 0, level.width, level.height, true);

		var healthBar = new FlxBar(7, 7, LEFT_TO_RIGHT, 100, 20, player, "health", 0, 10, true);
		healthBar.scrollFactor.set(0, 0);
		add(healthBar);
	}

	override public function update(elapsed:Float):Void
	{
		this.playerController.update();
		spawnTimer -= elapsed;
		if (spawnTimer <= 0) {
			spawnTimer = 6;
			var spawners = counterSpawners.members;
			new FlxRandom().shuffle(spawners);
			for (spawner in spawners) {
				spawner.spawn();
			}
		}
		barriers.update(elapsed);

		FlxG.collide(player, barriers.walls);
		FlxG.collide(enemies, barriers.walls);
		FlxG.collide(enemies, enemies);
		FlxG.overlap(playerBullets, barriers.walls, destroyBullet);

		super.update(elapsed);
	}

	function destroyBullet(bullet:Bullet, wall:FlxSprite):Void {
		bullet.kill();
	}
}
