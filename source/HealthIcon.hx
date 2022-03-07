package;

import flixel.FlxSprite;

class HealthIcon extends FlxSprite
{
	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 */
	public var sprTracker:FlxSprite;
	public var noAntialising:Array<String> = ['bf-pixel', 'senpai', 'senpai-angry', 'spirit', 'gf-pixel'];

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		changeIcon(char, isPlayer);
		scrollFactor.set();
	}

	public function changeIcon(char:String, isPlayer:Bool = false)
	{
		switch (char)
		{
			default:
				loadGraphic(Paths.image('iconGrid'), true, 150, 150);

				antialiasing = true;
				animation.add('bf', [0, 1], 0, false, isPlayer);
				animation.add('shaggy', [10, 11], 0, false, isPlayer);
				animation.add('sshaggy', [10, 11], 0, false, isPlayer);
				animation.add('dad', [10, 11], 0, false, isPlayer);
				animation.add('gf', [10, 11], 0, false, isPlayer);
		}

		for (i in noAntialising)
		{
			if (i == char)
				antialiasing = false;
		}

		animation.play(char);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}
