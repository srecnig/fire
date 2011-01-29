package
{
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{
		[Embed(source = "../images/grass1.png")] private var Tiles:Class;
		[Embed(source = '../data/tilemap.txt', mimeType = "application/octet-stream")] private var Map:Class;

		public var mapLayer:FlxGroup;
		public var map:FlxTilemap;

		
		override public function create():void
		{
			
			initMap();
			
			this.add(mapLayer);
		}
		
		override public function update():void  
		{
			super.update();
		}
		
		public function initMap():void
		{
			mapLayer = new FlxGroup();
			
			map = new FlxTilemap();
			map.drawIndex = 0;
			map.loadMap(new Map, Tiles, 48);
			mapLayer.add(map);
		}
	}
}