package
{
	public class Wind
	{
		private var energy_level:int;
		private var refresh_rate:int;
		private var use_rate:int;
		
		private var active:Boolean;
		// direction of the wind
		// 0 -> N, 1 -> NE, 2 -> E, 3 -> SE, 4 -> S, 5 -> SW, 6 -> W, 7 -> NW
		private var direction:int;
		
		public function Wind( _energy_level:int, _refresh_rate:int, _use_rate:int)
		{
			this.energy_level = _energy_level;
			this.refresh_rate = _refresh_rate;
			this.use_rate = _use_rate;
		}
		
		public function blow():void
		{
			this.energy_level -= this.use_rate;
		}
		
		public function refresh():void
		{
			this.energy_level += this.refresh_rate;
		}
		
		public function isActive():Boolean
		{
			return this.active;
		}
		
		public function setActive(_active:Boolean):void
		{
			this.active = _active;
		}
		
		public function setDirection(_direction:int):void
		{
			this.direction = _direction;
		}
		
		public function getDirection():int
		{
			return this.direction;
		}
	}
}