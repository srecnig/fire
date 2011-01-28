package
{
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{
		[Embed(source = "../images/grass1.png")] private var Tiles:Class;
		[Embed(source = '../data/tilemap.txt', mimeType = "application/octet-stream")] private var Map:String;

		public var mapLayer:FlxGroup;
		public var map:FlxTilemap;

		
		override public function create():void
		{
			//add(new FlxText(0,0,100,"Hello, World!")); //adds a 100px wide text field at position 0,0 (upper left)
			initMap();
			
			this.add(mapLayer);
		}
		
		public function initMap():void
		{
			mapLayer = new FlxGroup();
			map = new FlxTilemap();
			map.loadMap(Map, Tiles, 48, 48);
			mapLayer.add(map);
		}
	}
}