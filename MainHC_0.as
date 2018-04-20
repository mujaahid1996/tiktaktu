package 
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.ui.*;
	import flash.events.Event;
	import flash.utils.Timer;


	public class MainHC_0 extends MovieClip
	{
		var mulai1:Boolean;
		var turn;		
		
		var randomX:int;
		var randomO:int;
		var hasilX:String;
		var statusX:int;
		var timergiliran:Timer ; 
		var timeracak:Timer ;
		
		public function MainHC_0(){
			init(); //1.
			
			timergiliran= new Timer(50, 1);
			timeracak= new Timer(50, 1);
			
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
				//dialihkan ke komp
				timergiliran.addEventListener(TimerEvent.TIMER_COMPLETE, setKomputerX); 
				timergiliran.start();				
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
				
				//dialihkan ke komp
				timergiliran.addEventListener(TimerEvent.TIMER_COMPLETE, setKomputerX); 
				timergiliran.start();
				
			}
			else if (turn == b.text)
			{
				//simbol  x
				tmpPlace.gotoAndStop(3);

				//giliran player 1
				turn = a.text;
				statusTxt.text = a.text + "'s Turn!";
				
				//dialihkan ke komp
				timergiliran.addEventListener(TimerEvent.TIMER_COMPLETE, setKomputerO); 
				timergiliran.start();
				
			}

			tmpPlace.buttonMode = false;// abis dipilih, petak tdk bisa diklik 
			tmpPlace.removeEventListener(MouseEvent.CLICK, placeClicked);
			// abis dipilih, petak tdk punya event listener;

			cekMenang();
		}

		function setKomputerX(e:TimerEvent):void{
			randomX = 1 + Math.round(Math.random() * (9 - 1));
			
			if( this[ "place" + randomX ].currentFrame == 3 ){
				acakKomputerX();
			}else if( this[ "place" + randomX ].currentFrame == 2 ){
				acakKomputerX();
			}else{
				this[ "place" + randomX ] . gotoAndStop(3);
				this[ "place" + randomX ] . buttonMode = false;
				this[ "place" + randomX ] . removeEventListener(MouseEvent.CLICK, placeClicked);
				
				//giliran player 1
				turn = a.text;
				statusTxt.text = a.text + "'s Turn!";			
				cekMenang();
			}
		}
		function setKomputerO(e:TimerEvent):void{
			randomO = 1 + Math.round(Math.random() * (9 - 1));
			
			if( this[ "place" + randomO ].currentFrame == 3 ){
				acakKomputerO();
			}else if( this[ "place" + randomO ].currentFrame == 2 ){
				acakKomputerO();
			}else{
				this[ "place" + randomO ] . gotoAndStop(2);
				this[ "place" + randomO ] . buttonMode = false;
				this[ "place" + randomO ] . removeEventListener(MouseEvent.CLICK, placeClicked);
				
				//giliran player 2
				turn = b.text;
				statusTxt.text = b.text + "'s Turn!";
				cekMenang();
			}
		}
		
		function acakKomputerX(){			
			timeracak.addEventListener(TimerEvent.TIMER_COMPLETE, setKomputerX); 
			timeracak.start(); // Start the timer
		}
		function acakKomputerO(){			
			timeracak.addEventListener(TimerEvent.TIMER_COMPLETE, setKomputerO); 
			timeracak.start(); // Start the timer
		}
		
		function cekMenang()
		{

			var menang = false;

			for (var i=2; i<=3; ++i)
			{
				//trace("i = "+i);
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
					timergiliran.removeEventListener(TimerEvent.TIMER_COMPLETE, setKomputerO); 
					timergiliran.removeEventListener(TimerEvent.TIMER_COMPLETE, setKomputerX); 

					timeracak.removeEventListener(TimerEvent.TIMER_COMPLETE, setKomputerX);
					timeracak.removeEventListener(TimerEvent.TIMER_COMPLETE, setKomputerO);
				}
				else if (turn == b.text)
				{
					statusTxt.text = a.text + " win!";
					timergiliran.removeEventListener(TimerEvent.TIMER_COMPLETE, setKomputerO); 
					timergiliran.removeEventListener(TimerEvent.TIMER_COMPLETE, setKomputerX); 

					timeracak.removeEventListener(TimerEvent.TIMER_COMPLETE, setKomputerX);
					timeracak.removeEventListener(TimerEvent.TIMER_COMPLETE, setKomputerO);
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