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
			
			var background:FlxSprite = new FlxSprite(0, 0);
			background.createGraphic(624, 480, 0x2F000000); 
			this.add(background);
			
			var title:FlxText = new FlxText(0, 16, FlxG.width, "INSTRUCTIONS");
			title.setFormat (null, 60, 0xFFFFFFFF, "center");
			add(title);
			
			/*
			var instruction_string:String = "destroy as much as you can!\n\nthere's a fire in this charming scenery, but\nwithout ";
			instruction_string += "wise use of the wind (using your arrow\n keys), it will be extinguished pretty fast. but\n remember,";
			instruction_string += "the wind gets weaker if it's blown for\nsome time, and it takes some time to recharge (watch the ";
			instruction_string += "wind-power-bar at the top left).\nalso, remember that grass is ignited more easy than a house (or\n ";
			instruction_string += "a lake), and does not give away as much heat as a\nburning house (or a lake)."
			*/

			var instruction_string:String = "destroy as much as you can!\n\nthere's a fire in this charming scenery, but without ";
			instruction_string += "wise use of the wind (using your arrow keys), it will be extinguished pretty fast. but remember,";
			instruction_string += "the wind gets weaker if it's blown for some time, and it takes some time to recharge (watch the ";
			instruction_string += "wind-power-bar at the top left). also, remember that grass is ignited more easy than a house (or ";
			instruction_string += "a lake), and does not give away as much heat as a burning house (or a burning lake)."
				
			var instruction:FlxText = new FlxText(0, 100, FlxG.width, instruction_string);
			instruction.setFormat(null, 20, 0xFFFFFFFF, "center");
			this.add(instruction);
			
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