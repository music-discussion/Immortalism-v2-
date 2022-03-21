package;

import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;
import openfl.utils.AssetType;
import openfl.utils.Assets as OpenFlAssets;
import flixel.input.gamepad.FlxGamepad;
import openfl.Lib;

import sys.io.File;
import sys.FileSystem;
import flixel.graphics.FlxGraphic;
import openfl.display.BitmapData;

class Paths
{
	inline public static var SOUND_EXT = #if web "mp3" #else "ogg" #end;

	static var currentLevel:String;

	static public function setCurrentLevel(name:String)
	{
		currentLevel = name.toLowerCase();
	}

	static function getPath(file:String, type:AssetType, library:Null<String>)
	{
		if (library != null)
			return getLibraryPath(file, library);

		if (currentLevel != null)
		{
			var levelPath = getLibraryPathForce(file, currentLevel);
			if (OpenFlAssets.exists(levelPath, type))
				return levelPath;

			levelPath = getLibraryPathForce(file, "shared");
			if (OpenFlAssets.exists(levelPath, type))
				return levelPath;
		}

		return getPreloadPath(file);
	}

	inline static public function fileExists(key:String, type:AssetType, ?ignoreMods:Bool = false, ?library:String)
	{
		if(OpenFlAssets.exists(Paths.getShaggyPath(key, type))) {
			return true;
		}
		
		//if(FileSystem.exists(mods(key))) {
		//	return true;
		//}
		return false;
	}

	inline public static function getShaggyPreloadPath(file:String)
		{
			return 'assets/$file';
		}

	public static function getShaggyPath(file:String, type:AssetType, ?library:Null<String> = null)
		{
			if (library != null)
				return getLibraryPath(file, library);
	
			if (currentLevel != null)
			{
				var levelPath:String = '';
				if(currentLevel != 'shared') {
					levelPath = getLibraryPathForce(file, currentLevel);
					if (OpenFlAssets.exists(levelPath, type))
						return levelPath;
				}
	
				levelPath = getLibraryPathForce(file, "shared");
				if (OpenFlAssets.exists(levelPath, type))
					return levelPath;
			}
	
			return getShaggyPreloadPath(file);
		}

	static public function getLibraryPath(file:String, library = "preload")
	{
		return if (library == "preload" || library == "default") getPreloadPath(file); else getLibraryPathForce(file, library);
	}

	inline static function getLibraryPathForce(file:String, library:String)
	{
		return '$library:assets/$library/$file';
	}

	inline static function getPreloadPath(file:String)
	{
		return 'assets/$file';
	}

	inline static public function file(file:String, type:AssetType = TEXT, ?library:String)
	{
		return getPath(file, type, library);
	}

	inline static public function lua(key:String,?library:String)
	{
		return getPath('data/$key.lua', TEXT, library);
	}

	inline static public function luaImage(key:String, ?library:String)
	{
		return getPath('data/$key.png', IMAGE, library);
	}

	inline static public function txt(key:String, ?library:String)
	{
		return getPath('data/$key.txt', TEXT, library);
	}

	inline static public function xml(key:String, ?library:String)
	{
		return getPath('data/$key.xml', TEXT, library);
	}

	inline static public function json(key:String, ?library:String)
	{
		return getPath('data/$key.json', TEXT, library);
	}

	static public function sound(key:String, ?library:String)
	{
		return getPath('sounds/$key.$SOUND_EXT', SOUND, library);
	}

	inline static public function soundRandom(key:String, min:Int, max:Int, ?library:String)
	{
		return sound(key + FlxG.random.int(min, max), library);
	}

	inline static public function music(key:String, ?library:String)
	{
		return getPath('music/$key.$SOUND_EXT', MUSIC, library);
	}

	inline static public function hScript(file:String)
		{
			//return getPath('scripts/$script.txt', TEXT, library);
			return 'assets/scripts/$file/script.hscript';
		}

	inline static public function voices(song:String)
	{
		var songLowercase = StringTools.replace(song, " ", "-").toLowerCase();
			switch (songLowercase) {
				case 'dad-battle': songLowercase = 'dadbattle';
				case 'philly-nice': songLowercase = 'philly';
			}
		//return 'songs:assets/songs/${songLowercase}/Voices.$SOUND_EXT';
		return 'songs:assets/songs/${song.toLowerCase()}/Voices.$SOUND_EXT';
	}

	inline static public function inst(song:String)
	{
		var songLowercase = StringTools.replace(song, " ", "-").toLowerCase();
			switch (songLowercase) {
				case 'dad-battle': songLowercase = 'dadbattle';
				case 'philly-nice': songLowercase = 'philly';
			}
		//return 'songs:assets/songs/${songLowercase}/Inst.$SOUND_EXT';
		return 'songs:assets/songs/${song.toLowerCase()}/Inst.$SOUND_EXT';
	}

	inline static public function titleVoices(song:String)
		{
			var songLowercase = StringTools.replace(song, " ", "-").toLowerCase();
				switch (songLowercase) {
					case 'dad-battle': songLowercase = 'dadbattle';
					case 'philly-nice': songLowercase = 'philly';
				}
			return 'songs:assets/titlesongs/${songLowercase}/Voices.$SOUND_EXT';
		}
	
	inline static public function titleInst(song:String)
		{
			var songLowercase = StringTools.replace(song, " ", "-").toLowerCase();
				switch (songLowercase) {
					case 'dad-battle': songLowercase = 'dadbattle';
					case 'philly-nice': songLowercase = 'philly';
				}
			return 'songs:assets/titlesongs/${songLowercase}/Inst.$SOUND_EXT';
		}

	inline static public function image(key:String, ?library:String)
	{
		return getPath('images/$key.png', IMAGE, library);
	}

	inline static public function font(key:String)
	{
		return 'assets/fonts/$key';
	}

	inline static public function getSparrowAtlas(key:String, ?library:String)
	{
		return FlxAtlasFrames.fromSparrow(image(key, library), file('images/$key.xml', library));
	}

	inline static public function getPackerAtlas(key:String, ?library:String)
	{
		return FlxAtlasFrames.fromSpriteSheetPacker(image(key, library), file('images/$key.txt', library));
	}

	inline static public function getPreference(preference:String) // you don't even wanna know how long this silly little function took. //unused too.
	{
		var data:Dynamic = FlxG.save.data.thisIsNull; //this is set to null rn.
		var allPreferences:Array<String> = ['hellMode', 'pussyMode', 'windowShake', 'beaten', 'zoom', 'gracetmr', 'oldtimings', 'cacheImages', 'optimize', 'inputSHowm', 'scoreScreen', 'camzoom', 
		'customStrumLine', 'strumline', 'cpuStrums', 'botplay', 'InstantRespawn', 'resetButton', 'flashing', 'distractions', 'ghost', 'watermark', 'accuracyMod', 'frames', 'npsDisplay', 
		'scrollSpeed', 'fpsCap', 'fpsRain', 'changedHit', 'changedHitX', 'changedHitY', 'fps', 'songPosition', 'offset', 'accuracyDisplay', 'dfjk', 'missSounds', 'antialising', 'downscroll', 
		'newInput'];
		
		var allDataPreferences = [FlxG.save.data.hellMode, FlxG.save.data.pussyMode, FlxG.save.data.windowShake, FlxG.save.data.beaten, FlxG.save.data.zoom, FlxG.save.data.gracetmr, 
		FlxG.save.data.oldtimings, FlxG.save.data.cacheImages, FlxG.save.data.optimize, FlxG.save.data.inputShowm, FlxG.save.data.scoreScreen, FlxG.save.data.camzoom, FlxG.save.data.customStrumLine, 
		FlxG.save.data.strumline, FlxG.save.data.cpuStrums, FlxG.save.data.botplay, FlxG.save.data.InstantRespawn, FlxG.save.data.resetButton, FlxG.save.data.flashing, FlxG.save.data.distractions, 
		FlxG.save.data.ghost, FlxG.save.data.watermark, FlxG.save.data.accuracyMod, FlxG.save.data.frames, FlxG.save.data.npsDisplay, FlxG.save.data.scrollSpeed, FlxG.save.data.fpsCap, 
		FlxG.save.data.fpsRain, FlxG.save.data.changedHit, FlxG.save.data.changedHitX, FlxG.save.data.changedHitY, FlxG.save.data.fps, FlxG.save.data.songPosition, FlxG.save.data.offset, 
		FlxG.save.data.accuracyDisplay, FlxG.save.data.dfjk, FlxG.save.data.missSounds, FlxG.save.data.antialising, FlxG.save.data.downscroll, FlxG.save.data.newInput];

		for (i in allPreferences)
		{
			if (preference == i)
				data = allDataPreferences[Std.parseInt(i)];
		}

		trace(preference + ' is = to ' + data);
		return data;
	}
}
