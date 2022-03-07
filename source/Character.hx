package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.animation.FlxAnimationController;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';

	public var holdTimer:Float = 0;

	public var isPlayingAsBF:Bool;

	public var animations:Array<FlxAnimationController> = [];

	public var exSpikes:FlxSprite;

	public var otherFrames:Array<Character>;

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
	{
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;

		isPlayingAsBF = !FlxG.save.data.flip;

		var tex:FlxAtlasFrames;
		antialiasing = FlxG.save.data.antialiasing;

		switch (curCharacter)
		{
		case 'gf':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('characters/GF_assets');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');

		case 'bf':
				var tex = Paths.getSparrowAtlas('characters/BOYFRIEND', 'shared');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);
				animation.addByPrefix('singHey', 'BF HEY', 24, false);
				animation.addByPrefix('hit', 'BF hit', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset("singHey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);

				playAnim('idle');

				flipX = true;

		case 'bambi': // check
			tex = Paths.getSparrowAtlas('characters/bambi', 'shared');

			frames = tex;

			animation.addByPrefix('idle', "Idle", 24, false);
			animation.addByPrefix('singUP', "up", 24, false);
			animation.addByPrefix('singDOWN', "down", 24, false);
			animation.addByPrefix('singLEFT', 'left', 24, false);
			animation.addByPrefix('singRIGHT', 'right', 24, false);
			
			addOffset('idle');
			addOffset("singUP", 0, 0);
			addOffset("singRIGHT", 0, 0);
			addOffset("singLEFT", 0, 0);
			addOffset("singDOWN", 0, 0);
		case 'ron':  // check
			tex = Paths.getSparrowAtlas('characters/ron', 'shared');

			frames = tex;

			animation.addByPrefix('idle', "Idle", 24, false);
			animation.addByPrefix('singUP', "Sing Up", 24, false);
			animation.addByPrefix('singDOWN', "Sing Down", 24, false);
			animation.addByPrefix('singLEFT', 'Sing Left', 24, false);
			animation.addByPrefix('singRIGHT', 'Sing Right', 24, false);
			
			addOffset('idle');
			addOffset("singUP", 0, 0);
			addOffset("singRIGHT", 0, 0);
			addOffset("singLEFT", 0, 0);
			addOffset("singDOWN", 0, 0);
		case 'shaggy': // check
			tex = Paths.getSparrowAtlas('characters/shaggy', 'shared');

			frames = tex;
			animation.addByPrefix('idle', 'shaggy_idle', 24);
			animation.addByPrefix('idle2', 'shaggy_idle2', 24);
			animation.addByPrefix('singUP', 'shaggy_up', 20);
			animation.addByPrefix('singRIGHT', 'shaggy_right', 20);
			animation.addByPrefix('singDOWN', 'shaggy_down', 24);
			animation.addByPrefix('singLEFT', 'shaggy_left', 24);
			animation.addByPrefix('catch', 'shaggy_catch', 30);
			animation.addByPrefix('hold', 'shaggy_hold', 30);
			animation.addByPrefix('h_half', 'shaggy_h_half', 30);
			animation.addByPrefix('fall', 'shaggy_fall', 30);
			animation.addByPrefix('kneel', 'shaggy_half_ground', 30);

			animation.addByPrefix('power', 'shaggy_powerup', 30);
			animation.addByPrefix('idle_s', 'shaggy_super_idle', 24);
			animation.addByPrefix('singUP_s', 'shaggy_sup2', 20);
			animation.addByPrefix('singRIGHT_s', 'shaggy_sright', 20);
			animation.addByPrefix('singDOWN_s', 'shaggy_sdown', 24);
			animation.addByPrefix('singLEFT_s', 'shaggy_sleft', 24);

			addOffset('idle');
			addOffset('idle2');
			addOffset("singUP", -19, 29);
			addOffset("singRIGHT", -4, -39);
			addOffset("singLEFT", 164, -119);
			addOffset("singDOWN", -20, -173);
			addOffset("catch", 140, 90);
			addOffset("hold", 90, 100);
			addOffset("h_half", 90, 0);
			addOffset("fall", 130, 0);
			addOffset("kneel", 110, -123);

			addOffset('idle_s');
			addOffset('power', 10, 0);
			addOffset("singUP_s", -6, 0);
			addOffset("singRIGHT_s", -20, -40);
			addOffset("singLEFT_s", 100, -120);
			addOffset("singDOWN_s", 0, -170);

			playAnim('idle');
		case 'matt':  // check
				tex = Paths.getSparrowAtlas('characters/matt', 'shared');

				frames = tex;

				animation.addByPrefix('idle', "matt idle", 20, false);
				animation.addByPrefix('singUP', "matt up note", 24, false);
				animation.addByPrefix('singDOWN', "matt down note", 24, false);
				animation.addByPrefix('singLEFT', 'matt left note', 24, false);
				animation.addByPrefix('singRIGHT', 'matt right note', 24, false);

				animation.addByPrefix('singUPmiss', "miss up", 24, false);
				animation.addByPrefix('singDOWNmiss', "miss down", 24, false);
				animation.addByPrefix('singLEFTmiss', 'miss left', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'miss right', 24, false);

				addOffset('idle');
				addOffset("singUP", -41, 21);
				addOffset("singRIGHT", -10, -14);
				addOffset("singLEFT", 63, -24);
				addOffset("singDOWN", -62, -19);
		case 'tankman':  // check
			tex = Paths.getSparrowAtlas('characters/tankman', 'shared');
				
				frames = tex;
				
				animation.addByPrefix('idle', 'Idle', 24, false);
				animation.addByPrefix('singUP', 'Sing Up', 24, false);
				animation.addByPrefix('singDOWN', 'Sing Down', 24, false);
				animation.addByPrefix('singLEFT', 'Sing Left', 24, false);
				animation.addByPrefix('singRIGHT', 'Sing Right', 24, false);
				animation.addByPrefix('singUP-alt', 'Ugh', 24, false);

				addOffset('idle');
				addOffset("singUP", 42, 38);
				addOffset("singLEFT", 98, -27);
				addOffset("singRIGHT", -89, -51);
				addOffset("singDOWN", 40, -120);
				addOffset("singUP-alt", 71, -40);

				playAnim('idle');

			//	flipX = true;
		case 'little-man':
					tex = Paths.getSparrowAtlas('characters/Small_Guy', 'shared');
					frames = tex;
					animation.addByPrefix('idle', "idle", 24);
					animation.addByPrefix('singUP', 'up', 24, false);
					animation.addByPrefix('singDOWN', 'down', 24, false);
					animation.addByPrefix('singLEFT', 'left', 24, false);
					animation.addByPrefix('singRIGHT', 'right', 24, false);
					addOffset('idle');
					addOffset("singUP", -10, 8);
					addOffset("singLEFT", -8, 0);
					addOffset("singRIGHT", 0, 2);
					addOffset("singDOWN", 0, -10);
		case 'dave':  // check
			tex = Paths.getSparrowAtlas('characters/dave', 'shared');

			frames = tex;

			animation.addByPrefix('idle', "Idle", 24, false);
			animation.addByPrefix('singUP', "Up", 24, false);
			animation.addByPrefix('singDOWN', "Down", 24, false);
			animation.addByPrefix('singLEFT', 'Left', 24, false);
			animation.addByPrefix('singRIGHT', 'Right', 24, false);
			
			addOffset('idle');
			addOffset("singUP", 0, 0);
			addOffset("singRIGHT", 0, 0);
			addOffset("singLEFT", 0, 0);
			addOffset("singDOWN", 0, 0);
		case 'bob':  // check, wait i forgot tricky
			tex = Paths.getSparrowAtlas('characters/bob', 'shared');

			frames = tex;

			animation.addByPrefix('idle', "bob_idle", 24, false);
			animation.addByPrefix('singUP', "bob_UP", 24, false);
			animation.addByPrefix('singDOWN', "bob_DOWN", 24, false);
			animation.addByPrefix('singLEFT', 'bob_LEFT', 24, false);
			animation.addByPrefix('singRIGHT', 'bob_RIGHT', 24, false);
			
			addOffset('idle');
			addOffset("singUP", 0, 0);
			addOffset("singRIGHT", 0, 0);
			addOffset("singLEFT", 0, 0);
			addOffset("singDOWN", 0, 0);
			flipX = true;
		case 'tricky': // check, all done
			tex = Paths.getSparrowAtlas('characters/tricky', 'shared');
			frames = tex;

			animation.addByPrefix('idle', "Idle", 24, false);
			animation.addByPrefix('singUP', "Sing Up", 24, false);
			animation.addByPrefix('singDOWN', "Sing Down", 24, false);
			animation.addByPrefix('singLEFT', 'Sing Left', 24, false);
			animation.addByPrefix('singRIGHT', 'Sing Right', 24, false);
			
			addOffset('idle');
			addOffset("singUP", 100, -5);
			addOffset("singRIGHT", 33, -108);
			addOffset("singLEFT", 134, -5);
			addOffset("singDOWN", 17, -22);

			//bambi, ron, shaggy, matt, tankman, dave, bob, tricky
			//just realized after i forgot cheeky

			case 'cheeky':
				tex = Paths.getSparrowAtlas('characters/Cheeky', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'Cheeky Idle Dance', 24);
				animation.addByPrefix('singUP', 'Cheeky NOTE UP', 24);
				animation.addByPrefix('singRIGHT', 'Cheeky NOTE RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Cheeky NOTE DOWN', 24);
				animation.addByPrefix('singLEFT', 'Cheeky NOTE LEFT', 24);

				addOffset('idle', -21, -8);
				addOffset("singUP", -21, 33);
				addOffset("singRIGHT", -134, -20);
				addOffset("singLEFT", 68, -30);
				addOffset("singDOWN", -21, -68);

				playAnim('idle');
				//cheeky was hella small lmao
				setGraphicSize(Std.int(width * 2));

				flipX = false;

				case 'cheekygun':
					tex = Paths.getSparrowAtlas('characters/cheekgun', 'shared');
					frames = tex;
					animation.addByPrefix('idle', 'Cheeky Idle Dance', 24);
					animation.addByPrefix('singUP', 'Cheeky NOTE UP', 24);
					animation.addByPrefix('singRIGHT', 'Cheeky NOTE RIGHT', 24);
					animation.addByPrefix('singDOWN', 'Cheeky NOTE DOWN', 24);
					animation.addByPrefix('singLEFT', 'Cheeky NOTE LEFT', 24);
	
					//Gun Mechanic
					animation.addByPrefix('ShootGun', 'Cheeky PEW PEW', 24);
					addOffset("singLEFT", 303, -20);
	
					addOffset('idle', -21, -8);
					addOffset("singUP", -21, 43);
					addOffset("singRIGHT", 36, -30);
					addOffset("singLEFT", 303, -20);
					addOffset("singDOWN", -1, -58);
	
					playAnim('idle');
					//cheeky was hella small lmao
					setGraphicSize(Std.int(width * 2));
	
					flipX = false;

			case 'hellbob':
				tex = Paths.getSparrowAtlas('characters/hellbob_assets', 'shared');
				frames = tex;
				animation.addByPrefix('idle', "bobismad", 24);
				animation.addByPrefix('singUP', 'lol', 24, false);
				animation.addByPrefix('singDOWN', 'lol', 24, false);
				animation.addByPrefix('singUPmiss', 'lol', 24);
				animation.addByPrefix('singDOWNmiss', 'lol', 24);

				//addOffset('idle', 0, 27);

				playAnim('idle');

				flipX = true;

			case 'pshaggy':
					tex = Paths.getSparrowAtlas('characters/pshaggy', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'pshaggy_idle', 7, false);
				animation.addByPrefix('singUP', 'pshaggy_up', 28, false);
				animation.addByPrefix('singDOWN', 'pshaggy_down', 28, false);
				animation.addByPrefix('singLEFT', 'pshaggy_left', 28, false);
				animation.addByPrefix('singRIGHT', 'pshaggy_right', 28, false);
				animation.addByPrefix('back', 'pshaggy_back', 28, false);
				animation.addByPrefix('snap', 'pshaggy_snap', 7, false);
				animation.addByPrefix('snapped', 'pshaggy_did_snap', 28, false);
				animation.addByPrefix('smile', 'pshaggy_smile', 7, false);
				animation.addByPrefix('stand', 'pshaggy_stand', 7, false);

				addOffset("idle");
				addOffset("smile");
				var sOff = 20;
				addOffset("back", 0, -20 + sOff);
				addOffset("stand", 0, -20 + sOff);
				addOffset("snap", 10, 72 + sOff);
				addOffset("snapped", 0, 60 + sOff);
				addOffset("singUP", -6, 0);
				addOffset("singRIGHT", 0, 0);
				addOffset("singLEFT", 10, 0);
				addOffset("singDOWN", 60, -100);

				playAnim('idle', true);

				case 'crazycheeky':
					tex = Paths.getSparrowAtlas('characters/cheeky_god', 'shared');
					frames = tex;
					animation.addByPrefix('idle', 'Cheeky Idle Dance', 24);
					animation.addByPrefix('singUP', 'Cheeky NOTE UP', 24);
					animation.addByPrefix('singRIGHT', 'Cheeky NOTE RIGHT', 24);
					animation.addByPrefix('singDOWN', 'Cheeky NOTE DOWN', 24);
					animation.addByPrefix('singLEFT', 'Cheeky NOTE LEFT', 24);
	
					addOffset('idle', -21, -8);
					addOffset("singUP", -21, 33);
					addOffset("singRIGHT", -134, -20);
					addOffset("singLEFT", 68, -30);
					addOffset("singDOWN", -21, -68);
	
					playAnim('idle');
					//cheeky was hella small lmao
					setGraphicSize(Std.int(width * 2));
	
					flipX = false;

			case 'trickyH':
				tex = CachedFrames.cachedInstance.fromSparrow('idle', 'hellclwn/Tricky/Idle');

				frames = tex;

				graphic.persist = true;
				graphic.destroyOnNoUse = false;

				animation.addByPrefix('idle','Phase 3 Tricky Idle', 24);
				
				// they have to be left right up down, in that order.
				// cuz im too lazy to dynamicly get these names
				// cry about it

				otherFrames = new Array<Character>();
			
				otherFrames.push(new Character(100, 100, 'trickyHLeft'));
				otherFrames.push(new Character(100, 100, 'trickyHRight'));
				otherFrames.push(new Character(100, 100, 'trickyHUp'));
				otherFrames.push(new Character(100, 100, 'trickyHDown'));

				animations.push(animation);
				for (i in otherFrames)
					animations.push(animation);

				trace('poggers');

				addOffset("idle", 325, 0);
				playAnim('idle');

				case 'trickyHDown':
				tex = CachedFrames.cachedInstance.fromSparrow('down','hellclwn/Tricky/Down');

				frames = tex;

				graphic.persist = true;
				graphic.destroyOnNoUse = false;

				animation.addByPrefix('idle','Proper Down', 24);

				addOffset("idle",475, -450);

				y -= 2000;
				x -= 1400;

				playAnim('idle');
			case 'trickyHUp':
				tex = CachedFrames.cachedInstance.fromSparrow('up','hellclwn/Tricky/Up');


				frames = tex;

				graphic.persist = true;
				graphic.destroyOnNoUse = false;

				animation.addByPrefix('idle','Proper Up', 24);

				addOffset("idle", 575, -450);

				y -= 2000;
				x -= 1400;

				playAnim('idle');
			case 'trickyHRight':
				tex = CachedFrames.cachedInstance.fromSparrow('right','hellclwn/Tricky/right');

				frames = tex;

				graphic.persist = true;
				graphic.destroyOnNoUse = false;

				animation.addByPrefix('idle','Proper Right', 24);

				addOffset("idle",485, -300);

				y -= 2000;
				x -= 1400;

				playAnim('idle');
			case 'trickyHLeft':
				tex = CachedFrames.cachedInstance.fromSparrow('left','hellclwn/Tricky/Left');

				frames = tex;

				graphic.persist = true;
				graphic.destroyOnNoUse = false;

				animation.addByPrefix('idle','Proper Left', 24);

				addOffset("idle", 516, 25);

				y -= 2000;
				x -= 1400;
				
				playAnim('idle');

			case 'third-dave':
			tex = Paths.getSparrowAtlas('characters/Dave_Furiosity', 'shared');

			frames = tex;

			animation.addByPrefix('idle', "IDLE", 24, false);
			animation.addByPrefix('singUP', "UP", 24, false);
			animation.addByPrefix('singDOWN', "DOWN", 24, false);
			animation.addByPrefix('singLEFT', 'LEFT', 24, false);
			animation.addByPrefix('singRIGHT', 'RIGHT', 24, false);
			
			addOffset('idle');
			addOffset("singUP", 0, 0);
			addOffset("singRIGHT", 0, 0);
			addOffset("singLEFT", 0, 0);
			addOffset("singDOWN", 0, 0);

			//this shaggy is only shown for the troll song lol.
			case 'sshaggy':
			// SSHAGGY ANIMATION LOADING CODE
			tex = Paths.getSparrowAtlas('characters/shaggy', 'shared');
			frames = tex;
			animation.addByPrefix('idle2', 'shaggy_idle2', 15);
			animation.addByPrefix('idle', 'shaggy_super_idle0', 15);
			animation.addByPrefix('singUP', 'shaggy_sup0', 15);
			animation.addByPrefix('singRIGHT', 'shaggy_sright', 15);
			animation.addByPrefix('singDOWN', 'shaggy_sdown', 15); //god why does sshaggy have so many animations
			animation.addByPrefix('singLEFT', 'shaggy_sleft', 15);

			addOffset('idle');
			addOffset('idle2');
			addOffset("singUP", -16, 27);
			addOffset("singRIGHT", -1, -28);
			addOffset("singLEFT", 165, -114);
			addOffset("singDOWN", -10, -160);

			/*healthbar_colors = [
				51,
				114,
				74
			];*/

			playAnim('idle');
		}

		dance();

		//PlayState.instance.characterArray.push(curCharacter);
		//doesn't include bf, since his camera goes straight towards him???
		//also gf can suck his dic-
	//	if (!curCharacter.startsWith('bf')) {
	//		if (!curCharacter.startsWith('gf'))
	//			PlayState.instance.characterArray.push(this);
	//	}

		if (isPlayer)
		{
			flipX = !flipX;

			// Doesn't flip for BF, since his are already in the right place???
			if (!curCharacter.startsWith('bf'))
			{
				// var animArray
				var oldRight = animation.getByName('singRIGHT').frames;
				animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
				animation.getByName('singLEFT').frames = oldRight;

				// IF THEY HAVE MISS ANIMATIONS??
				if (animation.getByName('singRIGHTmiss') != null)
				{
					var oldMiss = animation.getByName('singRIGHTmiss').frames;
					animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
					animation.getByName('singLEFTmiss').frames = oldMiss;
				}
			}
		}
	}

	public function addOtherFrames()
		{
			
			for (i in otherFrames)
				{
					PlayState.staticVar.add(i);
					i.visible = false;
				}
		}

	override function update(elapsed:Float)
	{
		if (!isPlayingAsBF)
		{
			if (curCharacter.startsWith('bf') && !isPlayer)
				{
					if (animation.curAnim.name.startsWith('sing'))
					{
						holdTimer += elapsed;
					}
		
					var dadVar:Float = 4;
		
					if (curCharacter == 'dad')
						dadVar = 6.1;
					if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001)
					{
						trace('dance');
						dance();
						holdTimer = 0;
					}
				}
		
		}
		else
		{
			if (!isPlayer)
				{
					if (animation.curAnim.name.startsWith('sing'))
					{
						holdTimer += elapsed;
					}
		
					var dadVar:Float = 4;
		
					if (curCharacter == 'dad')
						dadVar = 6.1;
					if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001)
					{
						trace('dance');
						dance();
						holdTimer = 0;
					}
				}
		}

		super.update(elapsed);
	}

	private var danced:Bool = false;

	/**
	 * FOR GF DANCING SHIT
	 */
	public function dance()
	{
		if (!debugMode)
		{
			switch (curCharacter)
			{
				case 'gf':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'gf-christmas':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'gf-car':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}
				case 'gf-pixel':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'spooky':
					danced = !danced;

					if (danced)
						playAnim('danceRight');
					else
						playAnim('danceLeft');
				default:
					playAnim('idle');
			}
		}
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		if (otherFrames != null && PlayState.dad != null && PlayState.generatedMusic)
				{
					visible = false;
					for(i in otherFrames)
					{
						i.visible = false;
						i.x = x;
						i.y = y + 60;
					}

					switch(AnimName)
					{
						case 'singLEFT':
							otherFrames[0].visible = true;
							otherFrames[0].playAnim('idle', Force, Reversed, Frame);
						case 'singRIGHT':
							otherFrames[1].visible = true;
							otherFrames[1].playAnim('idle', Force, Reversed, Frame);
						case 'singUP':
							otherFrames[2].visible = true;
							otherFrames[2].playAnim('idle', Force, Reversed, Frame);
							otherFrames[2].y += 20;
						case 'singDOWN':
							otherFrames[3].visible = true;
							otherFrames[3].playAnim('idle', Force, Reversed, Frame);
						default:
							visible = true;

							animation.play(AnimName, Force, Reversed, Frame);

							var daOffset = animOffsets.get(AnimName);
							if (animOffsets.exists(AnimName))
								offset.set(daOffset[0], daOffset[1]);
							else
								offset.set(0, 0);
					}
				}
		else if (otherFrames != null && PlayState.dad != null)
			{
					visible = true;
					animation.play('idle', Force, Reversed, Frame);
					
					var daOffset = animOffsets.get('idle');
					if (animOffsets.exists('idle'))
						offset.set(daOffset[0], daOffset[1]);
					else
						offset.set(0, 0);
			} else {
		animation.play(AnimName, Force, Reversed, Frame);

		var daOffset = animOffsets.get(AnimName);
		if (animOffsets.exists(AnimName))
		{
			offset.set(daOffset[0], daOffset[1]);
		}
		else
			offset.set(0, 0);

		if (curCharacter == 'gf')
		{
			if (AnimName == 'singLEFT')
			{
				danced = true;
			}
			else if (AnimName == 'singRIGHT')
			{
				danced = false;
			}

			if (AnimName == 'singUP' || AnimName == 'singDOWN')
			{
				danced = !danced;
			}
		}
	}
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}
