package
{
	import org.flixel.*;
	
	public class CreditsState extends FlxState
	{
		[Embed(source = "../images/inc_tileset.png")] private var Tiles:Class;
		[Embed(source = '../data/menu_tilemap.txt', mimeType = "application/octet-stream")] private var Map:Class;
		
		private var mapLayer:FlxGroup;
		private var map:FlxTilemap;
		
		override public function create():void
		{
			this.initMap();
			this.add(mapLayer);
			
			var background:FlxSprite = new FlxSprite(0, 0);
			background.createGraphic(624, 480, 0x2F000000);
			this.add(background);
			
			var title:FlxText = new FlxText(0, 16, FlxG.width, "CREDITS");
			title.setFormat (null, 60, 0xFFFFFFFF, "center");
			add(title);
			
			var credits_string:String = "so long, and thanks for all the fish.\n\nthis game was made by:\nsrecnig, c4ux, vierlex\n\n";
			credits_string += "special thanks to:\nemi, #ggj11, #agj11\n\nsounds from freesound.org, for more details see:\n";
			credits_string += "freesound.org/usersAttribution.php?id=2005146\n";
			
			var credits:FlxText = new FlxText(0, 110, FlxG.width, credits_string);
			credits.setFormat(null, 20, 0xFFFFFFFF, "center");
			this.add(credits);
			
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