package
{
	
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{
		[Embed(source = "../images/inc_tileset.png")] private var Tiles:Class;
		[Embed(source = '../data/tilemap.txt', mimeType = "application/octet-stream")] private var Map:Class;
		[Embed(source="../images/wald.png")] private var ImgTiles:Class;
		
		public var mapLayer:FlxGroup;
		public var map:FlxTilemap;
		
		private var mapElements:Array = new Array();
		
		private var activeElements:Array= new Array();
		private var startPoint:FlxPoint = new FlxPoint(); 
		private var mapWidth:int = 5;
		private var mapHeight:int = 4;
		
		private var wind:Wind;
		private var wind_bar_frame:FlxSprite;
		private var wind_bar_inside:FlxSprite;
		private var wind_bar_bar:FlxSprite;
		
		// i think those are testing only
		private var stuff:BurningStuff;
		private var firesprite:FireSprite;
		
		private var text:FlxText;
		
		override public function create():void
		{
			initMap();
			initArray();
			
			// adds the tileset to the game
			this.add(mapLayer);
			
			// initialize firesprite testing only
			//firesprite = new FireSprite();
			//this.add(firesprite);
			
			// set fire start place
			startPoint = new FlxPoint(1,1);
			var bs:BurningStuff = mapElements[startPoint.x][startPoint.y].setOnFire();
			map.setTile(startPoint.x,startPoint.y,map.getTile(startPoint.x,startPoint.y)+1,true);
			activeElements[0] = startPoint;
			
			// add windbar (and initialize wind)
			initWind();
			
			// debug text
			text = new FlxText(0,30,100,"Hello, World!")
			this.add(text);
			
			//loadGraphic(ImgSpaceman,true,true,8);

		}
		
		override public function update():void  
		{
			super.update();
			burn();
			/*
			if(FlxG.keys.justPressed("B")) {
				map.setTile(1,1,2,true);
			}
			if(FlxG.keys.justPressed("N")) {
				map.setTile(1,1,0,true);
			}
			*/
			if (FlxG.keys.justPressed("K"))
				map.setTile(1,1,6,true);
			
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
		
		public function burn():void
		{
			var actMapPos:FlxPoint;
			//var actBurnStuff:BurningStuff;
			for (var i:int=0; i<activeElements.length; i++)
			{
				if (!(activeElements[i] == null)) {
					// init
					actMapPos = activeElements[i] as FlxPoint;
					
					// check wind
					/*if (wind.isActive())
						wind.getDirection();*/
					
					// check surrounding
					if (mapElements[actMapPos.x][actMapPos.y].getNeighbourhoodValue() == 0) {
						scorch(new FlxPoint(actMapPos.x-1,actMapPos.y-1));
						scorch(new FlxPoint(actMapPos.x,actMapPos.y-1));
						scorch(new FlxPoint(actMapPos.x+1,actMapPos.y-1));
						scorch(new FlxPoint(actMapPos.x-1,actMapPos.y));
						scorch(new FlxPoint(actMapPos.x,actMapPos.y));
						scorch(new FlxPoint(actMapPos.x+1,actMapPos.y));
						scorch(new FlxPoint(actMapPos.x-1,actMapPos.y+1));
						scorch(new FlxPoint(actMapPos.x,actMapPos.y+1));
						scorch(new FlxPoint(actMapPos.x+1,actMapPos.y+1));
					} else if (mapElements[actMapPos.x][actMapPos.y].getNeighbourhoodValue() == 1) {
						if (mapElements[actMapPos.x][actMapPos.y].getNeighboursUp()) {
							scorch(new FlxPoint(actMapPos.x-1,actMapPos.y-1));
							scorch(new FlxPoint(actMapPos.x,actMapPos.y-1));
							scorch(new FlxPoint(actMapPos.x+1,actMapPos.y-1));
							scorch(new FlxPoint(actMapPos.x-1,actMapPos.y));
							scorch(new FlxPoint(actMapPos.x,actMapPos.y));
							scorch(new FlxPoint(actMapPos.x+1,actMapPos.y));
						} else {
							scorch(new FlxPoint(actMapPos.x-1,actMapPos.y));
							scorch(new FlxPoint(actMapPos.x,actMapPos.y));
							scorch(new FlxPoint(actMapPos.x+1,actMapPos.y));
							scorch(new FlxPoint(actMapPos.x-1,actMapPos.y+1));
							scorch(new FlxPoint(actMapPos.x,actMapPos.y+1));
							scorch(new FlxPoint(actMapPos.x+1,actMapPos.y+1));
						}
					} else if (mapElements[actMapPos.x][actMapPos.y].getNeighbourhoodValue() == 2) {
						if (mapElements[actMapPos.x][actMapPos.y].getNeighboursLeft()) {
							scorch(new FlxPoint(actMapPos.x-1,actMapPos.y-1));
							scorch(new FlxPoint(actMapPos.x,actMapPos.y-1));							
							scorch(new FlxPoint(actMapPos.x-1,actMapPos.y));
							scorch(new FlxPoint(actMapPos.x,actMapPos.y));							
							scorch(new FlxPoint(actMapPos.x-1,actMapPos.y+1));
							scorch(new FlxPoint(actMapPos.x,actMapPos.y+1));	
						} else {						
							scorch(new FlxPoint(actMapPos.x,actMapPos.y-1));
							scorch(new FlxPoint(actMapPos.x+1,actMapPos.y-1));						
							scorch(new FlxPoint(actMapPos.x,actMapPos.y));
							scorch(new FlxPoint(actMapPos.x+1,actMapPos.y));							
							scorch(new FlxPoint(actMapPos.x,actMapPos.y+1));
							scorch(new FlxPoint(actMapPos.x+1,actMapPos.y+1));						}
					} else if (mapElements[actMapPos.x][actMapPos.y].getNeighbourhoodValue() == 3) {
						if (!mapElements[actMapPos.x][actMapPos.y].getNeighboursLeft() && !mapElements[actMapPos.x][actMapPos.y].getNeighboursUp()) {
							scorch(new FlxPoint(actMapPos.x,actMapPos.y));
							scorch(new FlxPoint(actMapPos.x+1,actMapPos.y));							
							scorch(new FlxPoint(actMapPos.x,actMapPos.y+1));
							scorch(new FlxPoint(actMapPos.x+1,actMapPos.y+1));
						} else if (!mapElements[actMapPos.x][actMapPos.y].getNeighboursUp() && !mapElements[actMapPos.x][actMapPos.y].getNeighboursRight()) {
							scorch(new FlxPoint(actMapPos.x-1,actMapPos.y));
							scorch(new FlxPoint(actMapPos.x,actMapPos.y));							
							scorch(new FlxPoint(actMapPos.x-1,actMapPos.y+1));
							scorch(new FlxPoint(actMapPos.x,actMapPos.y+1));																
						} else if (!mapElements[actMapPos.x][actMapPos.y].getNeighboursRight() && !mapElements[actMapPos.x][actMapPos.y].getNeighboursDown()) {
							scorch(new FlxPoint(actMapPos.x-1,actMapPos.y-1));
							scorch(new FlxPoint(actMapPos.x,actMapPos.y-1));							
							scorch(new FlxPoint(actMapPos.x-1,actMapPos.y));
							scorch(new FlxPoint(actMapPos.x,actMapPos.y));							
						} else if (!mapElements[actMapPos.x][actMapPos.y].getNeighboursDown() && !mapElements[actMapPos.x][actMapPos.y].getNeighboursLeft()) {						
							scorch(new FlxPoint(actMapPos.x,actMapPos.y-1));
							scorch(new FlxPoint(actMapPos.x+1,actMapPos.y-1));							
							scorch(new FlxPoint(actMapPos.x,actMapPos.y));
							scorch(new FlxPoint(actMapPos.x+1,actMapPos.y));
				
						} 
					}
						
					
					// check duration
					if (!mapElements[actMapPos.x][actMapPos.y].decreaseDuration(1)) {
						map.setTile(actMapPos.x,actMapPos.y,map.getTile(actMapPos.x,actMapPos.y)+1,true);
						activeElements[i]=null;
					}
				}
			}
		}
		
		public function scorch(point:FlxPoint):void {
			var value:int = 3;
			if (!mapElements[point.x][point.y].isBurnt() && !mapElements[point.x][point.y].isBurning()) {
				//var test:Boolean = !mapElements[point.x][point.y].decreaseThreshold(value)
				if (!mapElements[point.x][point.y].decreaseThreshold(value)) {
					map.setTile(point.x,point.y,map.getTile(point.x,point.y)+1,true);
					for (var i:int=0; i<activeElements.length; i++)
					{
						if (activeElements[i]==null) {
							activeElements[i] = point;
							return;
						}
					}
					activeElements.push(point);
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
		
		public function initArray():void
		{
			for (var x:int=0; x<mapWidth; x++) {
				mapElements[x] = new Array();
				for (var y:int=0; y<mapHeight; y++) {
					switch (map.getTile(x,y)) {
						case 0:
							mapElements[x][y] = new BurningStuff("Grass",300,100,30);
							break ;
						case 3:
							mapElements[x][y] = new BurningStuff("Wald",500,100,30);
							break ;
						case 6:
							mapElements[x][y] = new BurningStuff("Stadt",600,100,30);
							break ;
						case 9:
							mapElements[x][y] = new BurningStuff("See",1000,100,30);
							break ;
						default:
							mapElements[x][y] = new BurningStuff("Grass",300,100,30);
					} 
					if (y-1<0)
						mapElements[x][y].setNeighboursUp(false);
					if (x+1>=mapWidth)
						mapElements[x][y].setNeighboursRight(false);
					if (y+1>=mapHeight)
						mapElements[x][y].setNeighboursDown(false);
					if (x-1<0)
						mapElements[x][y].setNeighboursLeft(false);
					mapElements[x][y].checkNeighbours();
					mapElements[x][y].setTileX(x);
					mapElements[x][y].setTileY(y);
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