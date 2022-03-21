package;

import flixel.input.gamepad.FlxGamepad;
import Controls.KeyboardScheme;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import io.newgrounds.NG;
import lime.app.Application;

#if windows
import Discord.DiscordClient;
#end

using StringTools;

class MainMenuState extends MusicBeatState
{
	var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;

	#if !switch
	var optionShit:Array<String> = ['story mode', 'freeplay', 'donate', 'options'];
	#else
	var optionShit:Array<String> = ['story mode', 'freeplay'];
	#end

	var colorArray:Array<Int> = [0xFF9C0079, 0xFF61F02C, 0xFF57E88A, 0xFFE8F115];

	var newGaming:FlxText;
	var newGaming2:FlxText;
	public static var firstStart:Bool = true;

	public static var nightly:String = "";

	public static var kadeEngineVer:String = "0.1.4.1 IE RanDev";
	public static var gameVer:String = "0.2.7.1";
	public static var forceChange:Bool = false;

	var magenta:FlxSprite;
	var camFollow:FlxObject;
	public static var finishedFunnyMove:Bool = false;
	var defaultCamZoom:Dynamic;

	//characters to appear on the side of thing.
	private var shaggy:MainMenuCharacter;
	private var matt:MainMenuCharacter;
	private var cheeky:MainMenuCharacter;
	private var bob:MainMenuCharacter;
	
	var intendedColor:Int;
	var colorTween:FlxTween;
	var bg:FlxSprite;

	public var alreadyTriggered:Bool = false; //stops stuff from being triggered multiple times
	public var randomNum = FlxG.random.float(0.5, 2);
	public static var curSong:String = "Freaky Menu";
	public static var lastSong:String = "Freaky Menu";
	public static var songText:FlxText;

	override function create()
	{
		#if windows
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		if (!FlxG.sound.music.playing)
		{
			MainMenuState.curSong = 'Freaky Menu';
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}

		defaultCamZoom = FlxG.camera.zoom;
		trace(FlxG.camera.zoom);

		//TestIP.loadIP();

		persistentUpdate = persistentDraw = true;

		bg = new FlxSprite(-100).loadGraphic(Paths.image('menuDesat'));
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0.10;
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		magenta = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		magenta.scrollFactor.x = 0;
		magenta.scrollFactor.y = 0.10;
		magenta.setGraphicSize(Std.int(magenta.width * 1.1));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = true;
		magenta.color = 0xFFfd719b;
		add(magenta);
		// magenta.scrollFactor.set();

		var menuSide:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image('MenuThings/menu_outline'));
		menuSide.scrollFactor.x = 0;
		menuSide.scrollFactor.y = 0.10;
		menuSide.setGraphicSize(Std.int(menuSide.width * 1.1));
		menuSide.updateHitbox();
		menuSide.screenCenter();
		menuSide.visible = true;
		menuSide.antialiasing = true;
		menuSide.screenCenter(Y);
		menuSide.screenCenter(X);
		add(menuSide);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var tex = Paths.getSparrowAtlas('FNF_main_menu_assets');

		if (!alreadyTriggered) {
			FlxG.save.data.fakeDifficultyMultipliyer = randomNum;
			alreadyTriggered = true;
		}

		for (i in 0...optionShit.length)
		{
			trace('menu item ' + i);
			var menuItem:FlxSprite = new FlxSprite(30, FlxG.height * 1.6);
			menuItem.frames = tex;
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
		//	menuItem.screenCenter(X);
			menuItem.x += 20;
			menuItems.add(menuItem);
			menuItem.scrollFactor.set();
			menuItem.antialiasing = true;
			if (firstStart)
				FlxTween.tween(menuItem,{y: 60 + (i * 160)},1 + (i * 0.25) ,{ease: FlxEase.expoInOut, onComplete: function(flxTween:FlxTween) 
					{ 
						finishedFunnyMove = true; 
						changeItem();
					}});
			else
				menuItem.y = 60 + (i * 160);
		}

		if (FlxG.random.float(0, 10000) > 9800 || forceChange) {
			cheeky = new MainMenuCharacter(450, -300, 'cheekygun', true, false);
			matt = new MainMenuCharacter(600, -130, 'dave', true, false);
			bob = new MainMenuCharacter(350, -130, 'hellbob', true, false);
			shaggy = new MainMenuCharacter(650, -130, 'sshaggy', true, false);
		} else {
			cheeky = new MainMenuCharacter(450, -300, 'cheeky', true, false);
			matt = new MainMenuCharacter(600, -130, 'matt', true, false);
			bob = new MainMenuCharacter(350, -130, 'bob', true, false);
			shaggy = new MainMenuCharacter(650, -130, 'shaggy', true, false);
		}

		//cheeky.setGraphicSize(Std.int(cheeky.width * 0.8));
		//matt.setGraphicSize(Std.int(matt.width * 0.8));
		//bob.setGraphicSize(Std.int(bob.width * 0.8));
		//shaggy.setGraphicSize(Std.int(shaggy.width * 0.8));

		cheeky.screenCenter(Y);
		matt.screenCenter(Y);
		bob.screenCenter(Y);
		shaggy.screenCenter(Y);

		shaggy.y += 200;

		cheeky.y -= 200;

		bob.y += 100;

		add(cheeky);
		add(matt);
		add(bob);
		add(shaggy);

		cheeky.visible = false;
		matt.visible = false;
		bob.visible = false;
		shaggy.visible = false;

		firstStart = false;

		FlxG.camera.follow(camFollow, null, 0.60 * (60 / FlxG.save.data.fpsCap));

		/*var versionShit:FlxText = new FlxText(5, FlxG.height - 18, 0, gameVer +  (Main.watermarks ? " FNF - " + kadeEngineVer + " Immortalism Mod" : ""), 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);*/

		songText = new FlxText(12, FlxG.height - 84, 0, "Now Playing: " + curSong + (curSong == "Freaky Menu" ? " (Press F12 to change. Once you have pressed it, there is no going back to Freaky Menu.)" : ""), 12); 
		songText.scrollFactor.set();
		songText.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(songText);
		var versionShit:FlxText = new FlxText(12, FlxG.height - 64, 0, "Difficulty Modifier (restart game to change) : " + FlxG.save.data.fakeDifficultyMultipliyer, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
		var versionShit:FlxText = new FlxText(12, FlxG.height - 44, 0, "Immortalism Mod Version v" + kadeEngineVer, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
		var versionShit:FlxText = new FlxText(12, FlxG.height - 24, 0, "Friday Night Funkin' v0.2.7.1", 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		//songText = new FlxText(FlxG.width * 0.7, -1000, 0, "Now Playing: " + curSong, 20);
	//	songText.setFormat(Paths.font("vcr.ttf"), 24, FlxColor.WHITE, LEFT, OUTLINE, FlxColor.BLACK);
	//	songText.scrollFactor.set();
	//	add(songText);

		// NG.core.calls.event.logEvent('swag').send();


		if (FlxG.save.data.dfjk)
			controls.setKeyboardScheme(KeyboardScheme.Solo, true);
		else
			controls.setKeyboardScheme(KeyboardScheme.Duo(true), true);

		changeItem();
		Conductor.changeBPM(102);

		super.create();
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

	/*while (FlxG.camera.zoom > defaultCamZoom)
		{
			var counter:Int = 0;

			counter++;

			if (counter >= 200) {
				FlxG.camera.zoom = defaultCamZoom; //pressing 2 at once would cause 
				trace('sus');
			}
		}*/

		if (lastSong != curSong)
		{
			songText.text = "Now Playing: " + curSong;
			lastSong = curSong;
		}

		switch (optionShit[curSelected])
		{
			case 'story mode':
				cheeky.visible = true;
				matt.visible = false;
				bob.visible = false;
				shaggy.visible = false;

				cheeky.dance();
				cheeky.updateHitbox();
				var newColor:Int = colorArray[curSelected];
				if(newColor != intendedColor) {
				if(colorTween != null) {colorTween.cancel(); }
					intendedColor = newColor;
					colorTween = FlxTween.color(bg, 1, bg.color, intendedColor, {
						onComplete: function(twn:FlxTween) {
							colorTween = null;
						}
					});
				}
			case 'freeplay':
				cheeky.visible = false;
				matt.visible = true;
				bob.visible = false;
				shaggy.visible = false;

				matt.dance();
				matt.updateHitbox();
				var newColor:Int = colorArray[curSelected];
				if(newColor != intendedColor) {
				if(colorTween != null) {colorTween.cancel(); }
					intendedColor = newColor;
					colorTween = FlxTween.color(bg, 1, bg.color, intendedColor, {
						onComplete: function(twn:FlxTween) {
							colorTween = null;
						}
					});
				}
			case 'donate':
				cheeky.visible = false;
				matt.visible = false;
				bob.visible = true;
				shaggy.visible = false;

				bob.dance();
				bob.updateHitbox();
				var newColor:Int = colorArray[curSelected];
				if(newColor != intendedColor) {
				if(colorTween != null) {colorTween.cancel(); }
					intendedColor = newColor;
					colorTween = FlxTween.color(bg, 1, bg.color, intendedColor, {
						onComplete: function(twn:FlxTween) {
							colorTween = null;
						}
					});
				}
			case 'options':
				cheeky.visible = false;
				matt.visible = false;
				bob.visible = false;
				shaggy.visible = true;

				shaggy.dance();
				shaggy.updateHitbox();
				var newColor:Int = colorArray[curSelected];
				if(newColor != intendedColor) {
				if(colorTween != null) {colorTween.cancel(); }
					intendedColor = newColor;
					colorTween = FlxTween.color(bg, 1, bg.color, intendedColor, {
						onComplete: function(twn:FlxTween) {
							colorTween = null;
						}
					});
				}
		}

		if (!selectedSomethin)
		{
			var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

			if (gamepad != null)
			{
				if (gamepad.justPressed.DPAD_UP)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'));
					changeItem(-1);
			//		if (FlxG.camera.zoom > defaultCamZoom) //pressing 2 at once would cause it to be super zoomed in
			//			FlxG.camera.zoom = defaultCamZoom;
					//FlxTween.tween(FlxG.camera, {zoom:1.05}, 0.3, {ease: FlxEase.quadOut, type: BACKWARD});
				}
				if (gamepad.justPressed.DPAD_DOWN)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'));
					changeItem(1);
		//			if (FlxG.camera.zoom > defaultCamZoom) //pressing 2 at once would cause it to be super zoomed in
		//				FlxG.camera.zoom = defaultCamZoom;
				//	FlxTween.tween(FlxG.camera, {zoom:1.05}, 0.3, {ease: FlxEase.quadOut, type: BACKWARD});
				}
			}

			if (FlxG.keys.justPressed.UP)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			//	if (FlxG.camera.zoom > defaultCamZoom) //pressing 2 at once would cause it to be super zoomed in
		//			FlxG.camera.zoom = defaultCamZoom;
			//	FlxTween.tween(FlxG.camera, {zoom:1.05}, 0.3, {ease: FlxEase.quadOut, type: BACKWARD});
			}

			if (FlxG.keys.justPressed.DOWN)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
				//if (FlxG.camera.zoom > defaultCamZoom) //pressing 2 at once would cause it to be super zoomed in
			//		FlxG.camera.zoom = defaultCamZoom;
			//	FlxTween.tween(FlxG.camera, {zoom:1.05}, 0.3, {ease: FlxEase.quadOut, type: BACKWARD});
			}

			if (controls.BACK)
			{
			//	FlxG.switchState(new TitleState());
			}

			if (controls.ACCEPT)
			{
				if (optionShit[curSelected] == 'donate')
				{
					fancyOpenURL("https://ninja-muffin24.itch.io/funkin");
				}
				else if (optionShit[curSelected] == 'freeplay')
				{
					FlxG.sound.play(Paths.soundRandom('missnote', 1, 3, 'shared'), FlxG.random.float(0.1, 0.2));
				}
				else
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));
					
					if (FlxG.save.data.flashing)
						FlxFlicker.flicker(magenta, 1.1, 0.15, false);

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {alpha: 0}, 1.3, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									spr.kill();
								}
							});
						}
						else
						{
							if (FlxG.save.data.flashing)
							{
								FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
								{
									goToState();
								});
							}
							else
							{
								new FlxTimer().start(1, function(tmr:FlxTimer)
								{
									goToState();
								});
							}
						}
					});
				}
			}
		}

		if (FlxG.keys.justPressed.F12)
			TitleState.musicShit();

		super.update(elapsed);

		menuItems.forEach(function(spr:FlxSprite)
		{
	//		spr.screenCenter(X);
		});
	}
	
	function goToState()
	{
		var daChoice:String = optionShit[curSelected];

		switch (daChoice)
		{
			case 'story mode':
				FlxG.switchState(new StoryMenuState());
				trace("Story Menu Selected");
			case 'freeplay':
			//	FlxG.switchState(new FreeplayState());
				FlxG.sound.play(Paths.soundRandom('missnote', 1, 3), FlxG.random.float(0.1, 0.2));

				trace("Freeplay Menu Selected, oh wait it is locked");

			case 'options':
				FlxG.switchState(new OptionsMenu());
		}
	}

	function changeItem(huh:Int = 0)
	{
		if (finishedFunnyMove)
		{
			curSelected += huh;

			if (curSelected >= menuItems.length)
				curSelected = 0;
			if (curSelected < 0)
				curSelected = menuItems.length - 1;
		}
		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');

			if (spr.ID == curSelected && finishedFunnyMove)
			{
				spr.animation.play('selected');
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y);
			}

			spr.updateHitbox();
		});
	}

	override function beatHit()
	{
		super.beatHit();
		if (FlxG.camera.zoom > defaultCamZoom) //pressing 2 at once would cause it to be super zoomed in
			FlxG.camera.zoom = defaultCamZoom;
		FlxTween.tween(FlxG.camera, {zoom:1.05}, 0.3, {ease: FlxEase.quadOut, type: BACKWARD});
	}
}
