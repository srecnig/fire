package
{
	public class BurningStuff
	{
		private var type:String = "";
		private var burn_threshold:int = 0;
		private var burn_duration:int = 0;
		private var burn_energy:int = 0;
		
		// we have 4 states of 'burning'
		// 0 = normal
		// 1 = scorching (anbrennen)
		// 2 = burning
		// 3 = burnt
		private var burn_state:int = 0;
		
		//public tile_position_x;
		//public tile_position_y;
		
		public function BurningStuff(_type:String, _burn_threshold:int, _burn_duration:int, _burn_energy:int)
		{
			this.type = _type;
			this.burn_threshold = _burn_threshold; 
			this.burn_duration = _burn_duration;
			this.burn_energy = _burn_energy;
			
			this.burn_state = 0;
		}
		
		public function setOnFire():void
		{
			this.burn_state = 1;
		}
		
		public function setScorch():void
		{
			this.burn_state = 1;
		}
		
		public function setBurnt():void 
		{
			this.burn_state = 2;
		}
		
		public function isBurning():Boolean
		{
			if (this.burn_state == 2)
				return true;
			else
				return false;
		}
		
		public function isScorching():Boolean
		{
			if (this.burn_state == 1)
				return true;
			else
				return false;
		}
		
		public function decreaseThreshold(value:int):void
		{
			this.burn_threshold -= value; 
		}
		
		public function decreaseDuration(value:int):void
		{
			this.burn_duration -= value;
		}
	}
}