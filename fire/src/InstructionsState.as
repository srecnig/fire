package
{
	import org.flixel.*;
	
	public class InstructionsState extends FlxState
	{
		[Embed(source = "../images/inc_tileset.png")] private var Tiles:Class;
		[Embed(source = '../data/menu_tilemap.txt', mimeType = "application/octet-stream")] private var Map:Class;
		
		private var mapLayer:FlxGroup;
		private var map:FlxTilemap;
		
		override public function create():void
		{
			this.initMap();
			this.add(mapLayer);
			
			var title:FlxText = new FlxText(0, 16, FlxG.width, "INSTRUCTIONS");
			title.setFormat (null, 60, 0xFFFFFFFF, "center");
			add(title);
			
			var back_text:FlxText = new FlxText(0, 400, FlxG.width, "RETURN WITH ENTER");
			back_text.setFormat (null, 30, 0xFFFFFFFF, "center");
			this.add(back_text);
		}
		
		override public function update():void
		{
			super.update();
			
			if (FlxG.keys.justPressed("ENTER"))
			{
				FlxG.state = new WelcomeState();
			}
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