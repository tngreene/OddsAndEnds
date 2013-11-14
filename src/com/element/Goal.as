package com.element 
{
	import com.abstract.AGameElement;
	import com.abstract.AGameManager;

	public class Goal extends AGameElement
	{
		public function Goal(pGameManager:AGameManager) 
		{
			super(pGameManager);
			pGameManager.addChild(this);
		}
	}
}