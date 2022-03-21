import flixel.input.gamepad.FlxGamepad;
import openfl.Lib;
import flixel.FlxG;
import twelvekey.NoteVariables;

class KadeEngineData
{
    public static function initSave()
    {
        if (FlxG.save.data.newInput == null)
			FlxG.save.data.newInput = true;

		if (FlxG.save.data.downscroll == null)
			FlxG.save.data.downscroll = false;

		if (FlxG.save.data.antialiasing == null)
			FlxG.save.data.antialiasing = true;

		if (FlxG.save.data.missSounds == null)
			FlxG.save.data.missSounds = true;

		if (FlxG.save.data.dfjk == null)
			FlxG.save.data.dfjk = false;
			
		if (FlxG.save.data.accuracyDisplay == null)
			FlxG.save.data.accuracyDisplay = true;

		if (FlxG.save.data.offset == null)
			FlxG.save.data.offset = 0;

		if (FlxG.save.data.songPosition == null)
			FlxG.save.data.songPosition = false;

		if (FlxG.save.data.fps == null)
			FlxG.save.data.fps = false;

		if (FlxG.save.data.changedHit == null)
		{
			FlxG.save.data.changedHitX = -1;
			FlxG.save.data.changedHitY = -1;
			FlxG.save.data.changedHit = false;
		}

		if (FlxG.save.data.fpsRain == null)
			FlxG.save.data.fpsRain = false;

		if (FlxG.save.data.fpsCap == null)
			FlxG.save.data.fpsCap = 120;

		if (FlxG.save.data.fpsCap > 285 || FlxG.save.data.fpsCap < 60)
			FlxG.save.data.fpsCap = 120; // baby proof so you can't hard lock ur copy of kade engine
		
		if (FlxG.save.data.scrollSpeed == null)
			FlxG.save.data.scrollSpeed = 1;

		if (FlxG.save.data.npsDisplay == null)
			FlxG.save.data.npsDisplay = false;

		if (FlxG.save.data.frames == null)
			FlxG.save.data.frames = 10;

		if (FlxG.save.data.accuracyMod == null)
			FlxG.save.data.accuracyMod = 1;

		if (FlxG.save.data.watermark == null)
			FlxG.save.data.watermark = true;

		if (FlxG.save.data.ghost == null)
			FlxG.save.data.ghost = true;

		if (FlxG.save.data.distractions == null)
			FlxG.save.data.distractions = true;

		if (FlxG.save.data.flashing == null)
			FlxG.save.data.flashing = true;

		if (FlxG.save.data.resetButton == null)
			FlxG.save.data.resetButton = false;

		if (FlxG.save.data.InstantRespawn == null)
			FlxG.save.data.InstantRespawn = false;
		
		if (FlxG.save.data.botplay == null)
			FlxG.save.data.botplay = false;

		if (FlxG.save.data.cpuStrums == null)
			FlxG.save.data.cpuStrums = false;

		if (FlxG.save.data.strumline == null)
			FlxG.save.data.strumline = false;
		
		if (FlxG.save.data.customStrumLine == null)
			FlxG.save.data.customStrumLine = 0;

		if (FlxG.save.data.camzoom == null)
			FlxG.save.data.camzoom = true;

		if (FlxG.save.data.scoreScreen == null)
			FlxG.save.data.scoreScreen = true;

		if (FlxG.save.data.inputShow == null)
			FlxG.save.data.inputShow = false;

		if (FlxG.save.data.optimize == null)
			FlxG.save.data.optimize = false;
		
		if (FlxG.save.data.cacheImages == null)
			FlxG.save.data.cacheImages = false;

		if (FlxG.save.data.oldtimings == null)
			FlxG.save.data.oldtimings = false;

		if (FlxG.save.data.gracetmr == null)
			FlxG.save.data.gracetmr = true;

		if (FlxG.save.data.noteSplash == null)
			FlxG.save.data.noteSplash = true;

		if (FlxG.save.data.zoom == null)
			FlxG.save.data.zoom = 1;

		if (FlxG.save.data.noteColor == null)
			FlxG.save.data.noteColor = "darkred";

		if (FlxG.save.data.gthc == null)
			FlxG.save.data.gthc = false;

		if (FlxG.save.data.gthm == null)
			FlxG.save.data.gthm = false;

		if (FlxG.save.data.randomNotes == null)
			FlxG.save.data.randomNotes = false;

		if (FlxG.save.data.randomSection == null)
			FlxG.save.data.randomSection = true;

		if (FlxG.save.data.mania == null)
			FlxG.save.data.mania = 0;

		if (FlxG.save.data.randomMania == null)
			FlxG.save.data.randomMania = 0;

		if (FlxG.save.data.flip == null)
			FlxG.save.data.flip = false;

		if (FlxG.save.data.bothSide == null)
			FlxG.save.data.bothSide = false;

		if (FlxG.save.data.beaten == null)
			FlxG.save.data.beaten = false;

		if (FlxG.save.data.randomNoteTypes == null)
			FlxG.save.data.randomNoteTypes = 0;

		if (FlxG.save.data.windowShake == null)
			FlxG.save.data.windowShake = true;

		if (FlxG.save.data.pussyMode == null)
			FlxG.save.data.pussyMode = false;

		if (FlxG.save.data.hellMode == null)
			FlxG.save.data.hellMode = false;

		if (FlxG.save.data.middleScroll == null)
			FlxG.save.data.middleScroll = false;

		if (FlxG.save.data.middleScrollOP == null)
			FlxG.save.data.middleScrollOP = false;

		//leather_engine
		
		if (FlxG.save.data.F11Bind == null)
			FlxG.save.data.F11Bind = "F11";

		if (FlxG.save.data.pauseBind == null)
			FlxG.save.data.pauseBind = "ENTER";

		if (FlxG.save.data.remindEK == null)
			FlxG.save.data.remindEK = false;

		if (FlxG.save.data.unlockedMB == null)
			FlxG.save.data.unlockedMB = false;

		if (FlxG.save.data.unlockingMB == null)
			FlxG.save.data.unlockingMB = [false, false];

		#if debug
		trace('unlocking mb anyway');
		#end

		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;
		
		KeyBinds.gamepad = gamepad != null;

		Conductor.recalculateTimings();
		PlayerSettings.player1.controls.loadKeyBinds();
		KeyBinds.keyCheck();

		Main.watermarks = FlxG.save.data.watermark;

		(cast (Lib.current.getChildAt(0), Main)).setFPSCap(FlxG.save.data.fpsCap);
	}
}