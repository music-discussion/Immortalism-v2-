package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;

//leather_engine
import shaders.NoteColors;
import shaders.ColorSwap;
import twelvekey.NoteVariables;
import PlayState;

using StringTools;

class NoteSplash extends FlxSprite
{
	public static var colors:Array<String> = ['purple', 'blue', 'green', 'red', 'white', 'yellow', 'violet', 'black', 'darkblue'];
	var colorsThatDontChange:Array<String> = ['purple', 'blue', 'green', 'red', 'white', 'yellow', 'violet', 'black', 'darkblue', 'orange', 'darkred'];

	//leather_engine

	var target:FlxSprite;
    public var colorSwap:ColorSwap;

	public function new(nX:Float, nY:Float, color:Int, noteData:Int, target:FlxSprite, ?isPlayer:Bool = false)
	{
		if (!PlayState.leatherSplash) 
		{
		x = nX;
		y = nY;
		super(x, y);
		frames = Paths.getSparrowAtlas('noteassets/notesplash/Splash');
		for (i in 0...colorsThatDontChange.length)
		{
			animation.addByPrefix(colorsThatDontChange[i] + ' splash', "splash " + colorsThatDontChange[i], 24, false);
		}
		//animation.play('splash');
		antialiasing = true;
		updateHitbox();
		makeSplash(nX, nY, color);
		} else {
		x = nX;
		y = nY;
		super(x, y);

        this.target = target;

        var localKeyCount = PlayState.keyAmmo[PlayState.mania];

        alpha = 0.8;
        frames = PlayState.instance.splash_Texture;

        animation.addByPrefix("default", "note splash " + NoteVariables.Other_Note_Anim_Stuff[localKeyCount - 1][noteData] + "0", FlxG.random.int(22, 26), false);
        animation.play("default", true);

        setGraphicSize(Std.int(target.width * 2.5));

        updateHitbox();
        centerOrigin();
        centerOffsets();

        colorSwap = new ColorSwap();
		shader = colorSwap.shader;

		var noteColor = NoteColors.getNoteColor(NoteVariables.Other_Note_Anim_Stuff[localKeyCount - 1][noteData]);

		colorSwap.hue = noteColor[0] / 360;
		colorSwap.saturation = noteColor[1] / 100;
		colorSwap.brightness = noteColor[2] / 100;
		}
	}
	public function makeSplash(nX:Float, nY:Float, color:Int) 
	{
        setPosition(nX - 105, nY - 110);
		angle = FlxG.random.int(0, 360);
        alpha = 0.6;
        animation.play(colors[color] + ' splash', true);
		animation.curAnim.frameRate = 24 + FlxG.random.int(-2, 2);
		//offset.set(500, 200);
        updateHitbox();
    }

	override public function update(elapsed) 
	{
		if (!PlayState.leatherSplash) {
        if (animation.curAnim.finished)
		{
            kill();
        }
        super.update(elapsed);
		}  else {
			if(animation.curAnim.finished)
			{
				kill();
				alpha = 0;
			}
				
			x = target.x - (target.width / 1.5);
			y = target.y - (target.height / 1.5);
		
			color = target.color;
			
			flipX = target.flipX;
			flipY = target.flipY;
		
			angle = target.angle;
		
			super.update(elapsed);
		}
    }

}
