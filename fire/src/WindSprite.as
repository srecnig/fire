package
{
	import org.flixel.*;
	
	public class WindSprite extends FlxSprite
	{
		[Embed(source="../images/wind1.png")] private var wind_sprite_image:Class;
		
		public function WindSprite(_x:Number, _y:Number):void
		{
			super(_x, _y, wind_sprite_image);
			
			this.loadGraphic(wind_sprite_image, true, true, 310, 128);
			
			this.height = 310;
			this.width = 128;
			
			this.addAnimation("blow", [0, 1, 2, 3, 4], 10, true);
		}
		
		override public function update():void
		{
			super.update();
		}
		
		public function startAnimation():void
		{
			this.play("blow");
		}
		
		public function setDirection(direction:int):void
		{
			this.angle = direction;
		}
	}
}