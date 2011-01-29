package
{
	import org.flixel.*;
	
	public class SmokeSprite extends FlxSprite
	{
		[Embed(source="../images/rauch.png")] private var fire_sprite_image:Class;
		
		public function SmokeSprite(_x:Number, _y:Number):void
		{
			super(_x, _y, fire_sprite_image);
			
			this.loadGraphic(fire_sprite_image, true, true, 48, 48);
			
			this.height = 48;
			this.width = 48;
			
			this.addAnimation("smoking", [0, 1, 2 ], 4);
			
			this.play("smoking");
		}
		
		override public function update():void
		{
			super.update();
		}
	}
}