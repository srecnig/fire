package
{
	public class BurningStuff
	{
		private type:String;
		private burn_threshold:Int;
		private burn_duration:Int;
		private burn_energy:Int;
		private burn_state:String;
		
		//public tile_position_x;
		//public tile_position_y;
		
		public function BurningStuff(_type:String, _burn_threshold:Int, _burn_duration:Int, _burn_energy:Int, _burn_state:String)
		{
			this.type = _type;
			this.burn_threshold = _burn_threshold; 
			this.burn_duration = _burn_duration;
			this.burn_energy = _burn_energy;
			this.burn_state = _burn_state;
			
			this.state = "normal";
		}
		
		public function setOnFire()
		{
			this.state = burning;
		}
		
		public function setScorch()
		{
			this.state = "scorching";
		}
		
		public function setBurnt()
		{
			this.state = "burnt";
		}
		
		public function decreaseThreshold(value:Int)
		{
			this.burn_threshold -= value; 
		}
		
		public function decreaseDuration(value:Int)
		{
			this.burn_duration -= value;
		}
		
	}
}