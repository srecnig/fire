package
{
	import org.flixel.*;
	
	public class FireSprite extends FlxSprite
	{
		[Embed(source="../images/feuer.png")] private var fire_sprite_image:Class;

		public function FireSprite():void
		{
			super(50, 50, fire_sprite_image);
			
			this.loadGraphic(fire_sprite_image, true, true, 48, 48);
			
			this.height = 48;
			this.width = 48;
			
			this.addAnimation("burning", [0, 1, 2, 3 ], 5);
			
			play("burning");
		}
		
		override public function update():void
		{
			super.update();
		}
	}
}