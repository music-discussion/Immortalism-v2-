package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;

class SelfAwareState extends MusicBeatState
{
	public static var leftState:Bool = false;

	public static var needVer:String = "IDFK LOL";
	public static var currChanges:String = "dk";
	
	private var bgColors:Array<String> = [
		'#314d7f',
		'#4e7093',
		'#70526e',
		'#594465'
	];
	private var colorRotation:Int = 1;

	override function create()
	{
		super.create();

		FlxG.sound.playMusic(Paths.inst("adventure"));
		
		var txt:FlxText = new FlxText(0, 0, FlxG.width,
			"Your life is at risk. "
			+ "Let me explain. . "
			+ "\nThis game can grab your PC Name and other info."
			+ "\n\nIf you are streaming, this can be a bad thing.\n\n"
			+ "In order to turn this off, please press Y, \notherwise press anything else."
			+ "\nPlease Note:"
			+ "\n\nYou cannot change this option again, after pressing something. \n (this may be changed)"
			+ "\n\nSo, what its gonna be?",
			32);
		
			txt.setFormat("VCR OSD Mono", 32, FlxColor.fromRGB(200, 200, 200), CENTER);
			txt.borderColor = FlxColor.BLACK;
			txt.borderSize = 3;
			txt.borderStyle = FlxTextBorderStyle.OUTLINE;
			txt.screenCenter();
			add(txt);
	}

	override function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.Y)
		{
			FlxG.save.data.selfAware = true;
			FlxG.switchState(new TitleState());
			FlxG.sound.music.stop();
		} else if (FlxG.keys.justPressed.ANY)
		{
			FlxG.save.data.selfAware = false;
			FlxG.switchState(new TitleState());
			FlxG.sound.music.stop();
		}
		super.update(elapsed);
	}
}
