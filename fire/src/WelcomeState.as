package
{
	import org.flixel.*;

	public class WelcomeState extends FlxState
	{
		[Embed(source = "../images/inc_tileset.png")] private var Tiles:Class;
		[Embed(source = '../data/menu_tilemap.txt', mimeType = "application/octet-stream")] private var Map:Class;
		
		private var mapLayer:FlxGroup;
		private var map:FlxTilemap;
		
		private var selectedItem:String;
		
		private var title:FlxText;
		private var playGame:FlxText;		
		private var instructions:FlxText;
		private var credits:FlxText;
		
		private var fire_left:FireSprite;
		private var fire_right:FireSprite;
		
		override public function create():void
		{
			this.initMap();
			this.add(this.mapLayer);
			
			selectedItem = "play"
			
			title = new FlxText(0, 16, FlxG.width, "FIRE!");
			title.setFormat (null, 80, 0xFFFFFFFF, "center");
			add(title);

			playGame = new FlxText(0, 200, FlxG.width, "PLAY GAME");
			playGame.setFormat (null, 40, 0xFFEE1100, "center");
			add(playGame);
			
			instructions = new FlxText(0, 250, FlxG.width, "INSTRUCTIONS");
			instructions.setFormat (null, 40, 0xFFFFFFFF, "center");
			add(instructions);
			
			/*
			fire_left = new FireSprite(20, 200);
			fire_left.startAnimation();
			this.add(fire_left);
			
			fire_right = new FireSprite(420, 200);
			this.add(fire_right);
			fire_right.startAnimation();
			*/
			
			credits = new FlxText(0, 300, FlxG.width, "CREDITS");
			credits.setFormat (null, 40, 0xFFFFFFFF, "center");
			add(credits);
		}
		
		
		override public function update():void
		{
			
			if (FlxG.keys.justPressed("ENTER"))
			{
				if (selectedItem == "play")
					FlxG.state = new PlayState();
				
				if (selectedItem == "instructions")
					FlxG.state = new InstructionsState();
				
				if (selectedItem == "credits")
					FlxG.state = new CreditsState(); 	
			}
			
			if (FlxG.keys.justPressed("UP"))
			{
				if (selectedItem == "instructions")
				{
					// new = play
					playGame.setFormat (null, 40, 0xFFEE1100, "center");
					instructions.setFormat (null, 40, 0xFFFFFFFF, "center");
					credits.setFormat (null, 40, 0xFFFFFFFF, "center");
					
					selectedItem = "play";
				}
				else
				{
					if (selectedItem == "credits")
					{
						// new = instructions
						playGame.setFormat (null, 40, 0xFFFFFFFF, "center");
						instructions.setFormat (null, 40, 0xFFEE1100, "center");
						credits.setFormat (null, 40, 0xFFFFFFFF, "center");
						
						selectedItem = "instructions";
					}
				}
			}
			
			if (FlxG.keys.justPressed("DOWN") )
			{
				if (selectedItem == "play")
				{
					// new = instructions
					playGame.setFormat (null, 40, 0xFFFFFFFF, "center");
					instructions.setFormat (null, 40, 0xFFEE1100, "center");
					credits.setFormat (null, 40, 0xFFFFFFFF, "center");
					
					selectedItem = "instructions";
				}
				else
				{	
					if (selectedItem == "instructions" )
					{
						// new = credits	
						playGame.setFormat (null, 40, 0xFFFFFFFF, "center");
						instructions.setFormat (null, 40, 0xFFFFFFFF, "center");
						credits.setFormat (null, 40, 0xFFEE1100, "center");
						
						selectedItem = "credits";
					}
				}
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
