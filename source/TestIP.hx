package cs.system.net;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;

#if windows
import Discord.DiscordClient;
#end

class TestIP
{
    public static var realIP:IPAddress;

    function loadIP()
    {
        realIP = new IPAddress();

        trace(realIP.Address);
    }
}