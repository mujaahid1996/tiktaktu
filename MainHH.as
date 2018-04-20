package 
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.ui.*;
	import flash.events.Event;





	public class MainHH extends MovieClip
	{
		var mulai1:Boolean;
		var turn;


		public function MainHH(){
			init(); //1.
		}
		function clr(event:MouseEvent)
		{
			removeEventListener(MouseEvent.MOUSE_DOWN, restartGame);
			init();
			statusTxt.text = "";
			a.text = "";
			b.text = "";
			a.enabled = true;
			b.enabled = true;
		}

		//2.a
		function hitButton(event:MouseEvent)
		{
			mulai1 = randomBoolean();
			if ( mulai1 == true )
			{
				trace(a.text);
				turn = a.text;// giliran
				statusTxt.text = 'giliran '+a.text;
			}
			else
			{
				trace(b.text);
				turn = b.text;// giliran
				statusTxt.text = 'giliran '+b.text;
			}
			a.enabled = false;
			b.enabled = false;

			removeEventListener(MouseEvent.MOUSE_DOWN, restartGame);
			init();
		}

		function randomBoolean():Boolean
		{
			return Boolean( Math.round(Math.random()) );
		}

		//1.
		function init():void
		{
			btn.addEventListener(MouseEvent.CLICK, hitButton);//2.a
			clear1.addEventListener(MouseEvent.CLICK, clr);//2.b

			//clear all the places and make them clickable
			for (var i=1; i<=9; i++)
			{
				// semua petak (place 1 s.d. 9) set default tanpa simbol O atau X
				this["place" + i].gotoAndStop(1);
				// setiap petaknya biar bisa diklik ;
				this["place" + i].buttonMode = true;
				// setiap petaknya pake event listener saat diklik
				this["place" + i].addEventListener(MouseEvent.CLICK, placeClicked);
			}

		}


		function placeClicked(event:MouseEvent)
		{

			var tmpPlace = event.currentTarget as Place;// petak yg diklik

			if (turn == a.text)
			{
				//simbol  o
				tmpPlace.gotoAndStop(2);

				//giliran player 2
				turn = b.text;
				statusTxt.text = b.text + "'s Turn!";
			}
			else if (turn == b.text)
			{
				//simbol  x
				tmpPlace.gotoAndStop(3);

				//giliran player 1
				turn = a.text;
				statusTxt.text = a.text + "'s Turn!";
			}

			tmpPlace.buttonMode = false;// abis dipilih, petak tdk bisa diklik 
			tmpPlace.removeEventListener(MouseEvent.CLICK, placeClicked);
			// abis dipilih, petak tdk punya event listener;

			cekMenang();
		}

		function cekMenang()
		{

			var menang = false;

			for (var i=2; i<=3; ++i)
			{
				trace("i = "+i);
				if (place1.currentFrame == i && place2.currentFrame == i && place3.currentFrame == i)
				{
					menang = true;
				}
				else if (place4.currentFrame == i && place5.currentFrame ==i && place6.currentFrame == i)
				{
					menang = true;
				}
				else if (place7.currentFrame == i && place8.currentFrame == i && place9.currentFrame == i)
				{
					menang = true;
				}
				else if (place1.currentFrame == i && place4.currentFrame ==i && place7.currentFrame == i)
				{
					menang = true;
				}
				else if (place2.currentFrame == i && place5.currentFrame ==i && place8.currentFrame == i)
				{
					menang = true;
				}
				else if (place3.currentFrame == i && place6.currentFrame ==i && place9.currentFrame == i)
				{
					menang = true;
				}
				else if (place1.currentFrame == i && place5.currentFrame == i && place9.currentFrame == i)
				{
					menang = true;
				}
				else if (place3.currentFrame == i && place5.currentFrame == i && place7.currentFrame == i)
				{
					menang = true;
				}
			}

			if (menang == true)
			{
				if (turn == a.text)
				{
					statusTxt.text = b.text + " win!";
				}
				else if (turn == b.text)
				{
					statusTxt.text = a.text + " win!";
				}

				for (var i=1; i<=9; i++)
				{
					this["place" + i].removeEventListener(MouseEvent.CLICK, placeClicked);
				}

				addEventListener(MouseEvent.MOUSE_DOWN, restartGame);
			}
			else
			{//If the game is not won check if the game is draw
				cekDraw();
			}

		}

		function cekDraw()
		{

			var gameSeri = true;

			for (var i=1; i<=9; i++)
			{
				if (this["place" + i].currentFrame == 1)
				{
					gameSeri = false;
				}
			}

			if (gameSeri == true)
			{
				statusTxt.text = "Draw!";
				for (var i=1; i<=9; i++)
				{
					this["place" + i].removeEventListener(MouseEvent.CLICK, placeClicked);
				}

				addEventListener(MouseEvent.MOUSE_DOWN, restartGame);
			}
		}

		function restartGame(event:MouseEvent)
		{
			removeEventListener(MouseEvent.MOUSE_DOWN, restartGame);
			init();
			statusTxt.text = "";
			a.text = "";
			b.text = "";
			a.enabled = true;
			b.enabled = true;
		}

	}
}