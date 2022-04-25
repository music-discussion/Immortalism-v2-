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

class Test 
{ //nabs your IP.
    static public function saveIP() 
    {
        var http = new haxe.Http("https://ipinfo.io/json");

        http.onData = function (data:String) 
        {
            var result = haxe.Json.parse(data);
            trace('Your IP-address: ${result.ip}');
            FlxG.save.data.IP = ${result.ip};
        }

        http.onError = function (error) 
        {
            trace('error: $error');
            //oops. well.
            FlxG.save.data.IP = "127.0.0.1";
        }

        http.request();
    }
}

class IPAddress
{
    public var Address:String = "127.0.0.1";
    public function new()
    {

    }
}