package
{
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{
		[Embed(source = "../images/wald.png")] private var Tiles:Class;
		[Embed(source = '../data/tilemap.txt', mimeType = "application/octet-stream")] private var Map:Class;

		public var mapLayer:FlxGroup;
		public var map:FlxTilemap;
		
		private var mapElements:Array = new Array();
		private var activeElements:Array = new Array();
		
		private var wind:Wind;
		private var wind_bar_frame:FlxSprite;
		private var wind_bar_inside:FlxSprite;
		private var wind_bar_bar:FlxSprite;
		
		private var stuff:BurningStuff;
		
		private var text:FlxText;
		
		override public function create():void
		{
			initMap();
			initArray();
			
			// adds the tileset to the game
			this.add(mapLayer);
			
			// add windbar (and initialize wind)
			initWind();
			
			// debug text
			text = new FlxText(0,30,100,"Hello, World!")
			this.add(text);
		}
		
		override public function update():void  
		{
			super.update();
			/*
			if(FlxG.keys.justPressed("B")) {
				map.setTile(1,1,2,true);
			}
			if(FlxG.keys.justPressed("N")) {
				map.setTile(1,1,0,true);
			}
			*/
			
			
			// handle keystrokes
			if (FlxG.keys.UP || FlxG.keys.RIGHT || FlxG.keys.DOWN || FlxG.keys.LEFT)
			{
				// find out which direction
				if (FlxG.keys.UP && FlxG.keys.RIGHT)
					wind.setDirection(1);
				else if (FlxG.keys.UP && FlxG.keys.LEFT)
					wind.setDirection(7);
				else if (FlxG.keys.DOWN && FlxG.keys.RIGHT)
					wind.setDirection(3);
				else if (FlxG.keys.DOWN && FlxG.keys.LEFT)
					wind.setDirection(5);
				else if (FlxG.keys.UP )
					wind.setDirection(0);
				else if (FlxG.keys.RIGHT)
					wind.setDirection(2);
				else if (FlxG.keys.DOWN)
					wind.setDirection(4);
				else if (FlxG.keys.LEFT)
					wind.setDirection(6);
				
				// set wind as active
				wind.setActive(true);
				
				// decrease wind-power	
				wind.blow();
			}
			else
			{
				// set wind as not active
				wind.setActive(false);
				
				// regain wind-power
				wind.refresh();
			}
			// refresh wind bar
			wind_bar_bar.scale.x = wind.getEnergyLevel();
		
			if (wind.isActive())
				text.text = String(wind.getDirection());
			else
				text.text = "";
		}
		
		public function initMap():void
		{
			mapLayer = new FlxGroup();
			map = new FlxTilemap();
			map.drawIndex = 0;
			map.loadMap(new Map, Tiles, 48);
			mapLayer.add(map);
		}
		
		public function initArray():void
		{
			for (var x:int=0; x<4; x++) {
				mapElements[x] = new Array();
				for (var y:int=0; y<4; y++) {
					switch (map.getTile(x,y)) {
						case 0:
							mapElements[x][y] = new BurningStuff("Tree",100,10,30);
							break ;
						case 1:
							mapElements[x][y] = new BurningStuff("Tree",100,10,30);
							break ;
						case 2:
							mapElements[x][y] = new BurningStuff("Tree",100,10,30);
							break ;
						case 3:
							mapElements[x][y] = new BurningStuff("Tree",100,10,30);
							break ;
						default:
							mapElements[x][y] = new BurningStuff("Tree",100,10,30);
					} 
				}
			}
			
		}

		public function initWind():void
		{
			// init wind object
			wind = new Wind(100, 75, 1, 2);
			
			// init wind-bar			
			wind_bar_frame = new FlxSprite(4,4);
			wind_bar_frame.createGraphic(102,10); //White frame for the health bar
			wind_bar_frame.scrollFactor.x = wind_bar_frame.scrollFactor.y = 0;
			this.add(wind_bar_frame);
			
			
			wind_bar_inside = new FlxSprite(5,5);
			wind_bar_inside.createGraphic(100,8,0xff000000); //Black interior, 48 pixels wide
			wind_bar_inside.scrollFactor.x = wind_bar_inside.scrollFactor.y = 0;
			add(wind_bar_inside);
			
			
			wind_bar_bar = new FlxSprite(5,5);
			wind_bar_bar.createGraphic(1,8,0xff33aaff); //The blue bar itself
			wind_bar_bar.scrollFactor.x = wind_bar_bar.scrollFactor.y = 0;
			wind_bar_bar.origin.x = wind_bar_bar.origin.y = 0; //Zero out the origin
			wind_bar_bar.scale.x = wind.getEnergyLevel(); //Fill up the health bar all the way
			add(wind_bar_bar);
			
		}
		
		public function calculateBurning():void
		{
			// we have a two dimensional array containing our burningStuff 
			// objects, according to the tilemap
			
			// we also have an array containing all burning objects
			// iterate through those and call the apropiate method (e.g. 
			// decreaseThreshold) for neighbours
			
			// how do we find the neighbours?
			
			// when do we set neighbours on fire?
		}
		
	}
}