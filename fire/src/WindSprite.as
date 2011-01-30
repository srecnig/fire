package
{
	import org.flixel.*;
	
	public class WindSprite extends FlxSprite
	{
		[Embed(source="../images/wind2a.png")] private var wind_sprite_image:Class;
		
		public function WindSprite(_x:Number, _y:Number):void
		{
			super(_x, _y, wind_sprite_image);
			
			this.loadGraphic(wind_sprite_image, true, true, 320, 96);
			
			this.height = 320;
			this.width = 96;
			
			this.addAnimation("blow", [0, 1, 2, 3, 4, 5, 6], 10, true);
			this.addAnimation("empty", [8], 10, true);
			//var multi:int = 0.6;
			this.scale = new FlxPoint(4,4);
		}
		
		override public function update():void
		{
			super.update();
		}
		
		public function startAnimation():void
		{
			this.play("blow");
		}
		
		public function startEmptyAnimation():void
		{
			this.play("empty");
		}
		
		public function setDirection(direction:int):void
		{
			this.angle = direction;
		}
	}
}