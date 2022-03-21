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

import flixel.system.FlxAssets;
import flixel.system.FlxSound;

#if windows
import Sys;
import sys.FileSystem;
#end

import flash.system.System;

#if windows
import Discord.DiscordClient;
#end

class CheatingState extends MusicBeatState
{
    public var fakeCheating:Bool = true;
    public static var closedWindow = false;
    override function create()
    {
        super.create();

        #if windows
		// Updating Discord Rich Presence
        if (fakeCheating)
	    	DiscordClient.changePresence("Landed Themselves in the Cheating Zone by Chance", null);
        else 
            DiscordClient.changePresence("Landed Themselves in the Cheating Zone by Hacking", null);
		#end

        if (FlxG.sound.music.playing)
            
            FlxG.sound.music.stop();

        if (!FlxG.sound.music.playing)
        {
            var random = FlxG.random.int(1, 10);
            if (random == 7)
                FlxG.sound.playMusic(Paths.music('CHEATING_SCARY'));
            else
                FlxG.sound.playMusic(Paths.music('CHEATING'));
        }

        var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('CHEATING'));
        bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0.10;
		bg.setGraphicSize(Std.int(bg.width * 1.7));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);

        if (controls.BACK)
        {
            System.exit(0);
        }
    }

    override function beatHit()
    {
        super.beatHit();

        trace(curBeat);
        FlxTween.tween(FlxG.camera, {zoom:1.05}, 0.3, {ease: FlxEase.quadOut, type: BACKWARD});

        if (fakeCheating && !closedWindow)
        {
            switch (curBeat)
            {
                case 50:
                  FlxG.sound.music.stop();
                  FlxG.switchState(new MainMenuState());
            }
        }
    }
}