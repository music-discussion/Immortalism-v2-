package;

//this is for change character event lol.

import openfl.display3D.textures.VideoTexture;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.tweens.FlxEase;
import openfl.filters.ShaderFilter;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import openfl.geom.Matrix;
import openfl.display.BitmapData;
import lime.app.Application;
import flixel.FlxSprite;
import llua.Convert;
import llua.Lua;
import llua.State;
import llua.LuaL;
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;

class ChangeChar
{
    //Discussions why tf is it not like in PlayState???

    //ummm, well, idk man, I'm lazy.

	function changeGFCharacter(id:String, x:Float, y:Float, fix:Bool)
        {		
                        PlayState.instance.removeObject(PlayState.gf);
                        //PlayState.gf = new Character(x, y, null);
                        PlayState.instance.destroyObject(PlayState.gf);
                        PlayState.gf = new Character(x, y, id);
                        PlayState.gf.scrollFactor.set(0.95, 0.95);
                        PlayState.instance.addObject(PlayState.gf);
                        if (fix)
                        {
                            PlayState.instance.removeObject(PlayState.dad);
                            PlayState.instance.addObject(PlayState.dad);
                            PlayState.instance.removeObject(PlayState.boyfriend);
                            PlayState.instance.addObject(PlayState.boyfriend);
                        }
        }
    
        function changeDadCharacter(id:String, x:Float, y:Float)
        {		
                        PlayState.instance.removeObject(PlayState.dad);
                        //PlayState.dad = new Character(x, y, null);
                        PlayState.instance.destroyObject(PlayState.dad);
                        PlayState.dad = new Character(x, y, id);
                        PlayState.instance.addObject(PlayState.dad);
                        PlayState.instance.iconP2.animation.play(id);
        }
    
        function changeBoyfriendCharacter(id:String, x:Float, y:Float)
        {							
                        PlayState.instance.removeObject(PlayState.boyfriend);
                        //PlayState.boyfriend = new Boyfriend(x, y, null);
                        PlayState.instance.destroyObject(PlayState.boyfriend);
                        PlayState.boyfriend = new Boyfriend(x, y, id);
                        PlayState.instance.addObject(PlayState.boyfriend);
                        PlayState.instance.iconP1.animation.play(id);
        }
    
        // this is better. easier to port shit from playstate.
        //stolen from blantados.

        public static function changeGFCharacterBetter(x:Float, y:Float, id:String)
        {		
                        PlayState.instance.removeObject(PlayState.gf);
                        //PlayState.gf = new Character(x, y, null);
                        PlayState.instance.destroyObject(PlayState.gf);
                        PlayState.gf = new Character(x, y, id);
                        PlayState.gf.scrollFactor.set(0.95, 0.95);
                        PlayState.instance.addObject(PlayState.gf);
        }
    
        public static function changeDadCharacterBetter(x:Float, y:Float, id:String)
        {		
                        PlayState.instance.removeObject(PlayState.dad);
                        //PlayState.dad = new Character(x, y, null);
                        PlayState.instance.destroyObject(PlayState.dad);
                        PlayState.dad = new Character(x, y, id);
                        PlayState.instance.addObject(PlayState.dad);
                        PlayState.instance.iconP2.animation.play(id);
        }

       /* function changeDad2CharacterBetter(x:Float, y:Float, id:String) //maybe soon.
            {		
                            PlayState.instance.removeObject(PlayState.dad2);
                            //PlayState.dad = new Character(x, y, null);
                            PlayState.instance.destroyObject(PlayState.dad2);
                            PlayState.dad2 = new Character(x, y, id);
                            PlayState.instance.addObject(PlayState.dad2);
                            PlayState.instance.iconP2.animation.play(id);
            }
        
        function changeDad3CharacterBetter(x:Float, y:Float, id:String)
            {		
                            PlayState.instance.removeObject(PlayState.dad3);
                            //PlayState.dad = new Character(x, y, null);
                            PlayState.instance.destroyObject(PlayState.dad3);
                            PlayState.dad3 = new Character(x, y, id);
                            PlayState.instance.addObject(PlayState.dad3);
                            PlayState.instance.iconP2.animation.play(id);
            }
        
        function changeDad4CharacterBetter(x:Float, y:Float, id:String)
            {		
                            PlayState.instance.removeObject(PlayState.dad4);
                            //PlayState.dad = new Character(x, y, null);
                            PlayState.instance.destroyObject(PlayState.dad4);
                            PlayState.dad4 = new Character(x, y, id);
                            PlayState.instance.addObject(PlayState.dad4);
                            PlayState.instance.iconP2.animation.play(id);
            }*/
        
            public static function changeBoyfriendCharacterBetter(x:Float, y:Float, id:String)
            {		
                            PlayState.instance.removeObject(PlayState.boyfriend);
                            //PlayState.boyfriend = new Character(x, y, null);
                            PlayState.instance.destroyObject(PlayState.boyfriend);
                            PlayState.boyfriend = new Boyfriend(x, y, id);
                            PlayState.instance.addObject(PlayState.boyfriend);
                            PlayState.instance.iconP2.animation.play(id);
            }
  /*          function changeBoyfriend2CharacterBetter(x:Float, y:Float, id:String) //who knows maybe adding a song like godspeed to the game.
                {		
                                PlayState.instance.removeObject(PlayState.bf2);
                                //PlayState.boyfriend = new Character(x, y, null);
                                PlayState.instance.destroyObject(PlayState.bf2);
                                PlayState.bf2 = new Character(x, y, id);
                                PlayState.instance.addObject(PlayState.bf2);
                                PlayState.instance.iconP2.animation.play(id);
                }
            
            function changeBoyfriend3CharacterBetter(x:Float, y:Float, id:String)
                {		
                                PlayState.instance.removeObject(PlayState.bf3);
                                //PlayState.boyfriend = new Character(x, y, null);
                                PlayState.instance.destroyObject(PlayState.bf3);
                                PlayState.bf3 = new Character(x, y, id);
                                PlayState.instance.addObject(PlayState.bf3);
                                PlayState.instance.iconP2.animation.play(id);
                }
            
            function changeBoyfriend4CharacterBetter(x:Float, y:Float, id:String)
                {		
                                PlayState.instance.removeObject(PlayState.bf4);
                                //PlayState.boyfriend = new Character(x, y, null);
                                PlayState.instance.destroyObject(PlayState.bf4);
                                PlayState.bf4 = new Character(x, y, id);
                                PlayState.instance.addObject(PlayState.bf4);
                                PlayState.instance.iconP2.animation.play(id);
                }*/
}