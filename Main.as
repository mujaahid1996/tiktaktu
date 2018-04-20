package 
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.ui.*;
	import flash.events.Event;
	import flash.utils.Timer;


	public class Main extends MovieClip
	{
		var mulai1:Boolean;
		var turn;		
		
		var randomX:int;
		var randomO:int;
		var hasilX:String;
		var statusX:int;
		var timergiliran:Timer ; 
		var timeracak:Timer ;

		var nilaiHasilAcak:int;
		var array : Array;
		var arrayAcak:Array; 
		
		public function Main(){
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
				statusTxt.text = 'Giliran '+a.text;
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

		function randomBoolean():Boolean{			
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
				statusTxt.text = "Giliran " + b.text;
				
				//dialihkan ke komp (AI to win)
				winAiX();

//				timergiliran.addEventListener(TimerEvent.TIMER_COMPLETE, setKomputerX); 
//				timergiliran.start();
				
			}
			else if (turn == b.text)
			{
				//simbol  x
				tmpPlace.gotoAndStop(3);

				//giliran player 1
				turn = a.text;
				statusTxt.text = "Giliran " + a.text ;
				
				//dialihkan ke komp (AI to win)
				winAiO();

//				timergiliran.addEventListener(TimerEvent.TIMER_COMPLETE, setKomputerO); 
//				timergiliran.start();
				
			}

			tmpPlace.buttonMode = false;// abis dipilih, petak tdk bisa diklik 
			tmpPlace.removeEventListener(MouseEvent.CLICK, placeClicked);
			// abis dipilih, petak tdk punya event listener;

			cekMenang();
		}

		function acakNilai(param1:int, param2:int):void{	/* nyimpen hasil random ke variabel nilaiHasilAcak */
			nilaiHasilAcak = Math.floor(Math.random() * (param2 - param1 + 1)) + param1;
		}
		function acakArray(param:Array):void{
			arrayAcak = new Array();
			while( param.length>0 ){
					arrayAcak.push(param.splice(Math.floor(Math.random()*param.length), 1));
			}
			nilaiHasilAcak = arrayAcak[0];
		}

		function winAiX(){
			//3 petak kosong horizontal
			//row 1
			if( place1 .currentFrame==1 && place2 .currentFrame==1 && place3 .currentFrame==1 ){
				acakNilai(1,3); 
				this["place"+nilaiHasilAcak].gotoAndStop(3);				
				pindahKeP1();
			}
			//row 2
			else if( place4 .currentFrame==1 && place5 .currentFrame==1 && place6 .currentFrame==1 ){
				acakNilai(4,6); 
				this["place"+nilaiHasilAcak].gotoAndStop(3);
				pindahKeP1();
			}
			//row 3
			else if( place7 .currentFrame==1 && place8 .currentFrame==1 && place9 .currentFrame==1 ){
				acakNilai(7,9); 
				this["place"+nilaiHasilAcak].gotoAndStop(3);
				pindahKeP1();
			}
			//3 petak kosong vertikal
			//column 1
			else if( place1 .currentFrame==1 && place4 .currentFrame==1 && place7 .currentFrame==1 ){				
				array = [1,4,7];
				acakArray(array);			
				this["place"+nilaiHasilAcak].gotoAndStop(3);
				pindahKeP1();
			}
			//column 2
			else if( place2 .currentFrame==1 && place5 .currentFrame==1 && place8 .currentFrame==1 ){				
				array = [2,5,8];
				acakArray(array);			
				this["place"+nilaiHasilAcak].gotoAndStop(3);
				pindahKeP1();
			}
			//column 3
			else if( place3 .currentFrame==1 && place6 .currentFrame==1 && place9 .currentFrame==1 ){				
				array = [3,6,9];
				acakArray(array);			
				this["place"+nilaiHasilAcak].gotoAndStop(3);
				pindahKeP1();
			}	
			//end WinAiX()					
		}		
		function winAiO(){
			//3 petak kosong horizontal
			//row 1
			if( place1 .currentFrame==1 && place2 .currentFrame==1 && place3 .currentFrame==1 ){
				acakNilai(1,3); 
				this["place"+nilaiHasilAcak].gotoAndStop(2);
				pindahKeP2();
			}
			//row 2
			else if( place4 .currentFrame==1 && place5 .currentFrame==1 && place6 .currentFrame==1 ){
				acakNilai(4,6); 
				this["place"+nilaiHasilAcak].gotoAndStop(2);
				pindahKeP2();
			}
			//row 3
			else if( place7 .currentFrame==1 && place8 .currentFrame==1 && place9 .currentFrame==1 ){
				acakNilai(7,9); 
				this["place"+nilaiHasilAcak].gotoAndStop(2);
				pindahKeP2();
			}
			//3 petak kosong vertikal
			//column 1
			else if( place1 .currentFrame==1 && place4 .currentFrame==1 && place7 .currentFrame==1 ){				
				array = [1,4,7];
				acakArray(array);			
				this["place"+nilaiHasilAcak].gotoAndStop(2);
				pindahKeP2();
			}
			//column 2
			else if( place2 .currentFrame==1 && place5 .currentFrame==1 && place8 .currentFrame==1 ){				
				array = [2,5,8];
				acakArray(array);			
				this["place"+nilaiHasilAcak].gotoAndStop(2);
				pindahKeP2();
			}
			//column 3
			else if( place3 .currentFrame==1 && place6 .currentFrame==1 && place9 .currentFrame==1 ){				
				array = [3,6,9];
				acakArray(array);			
				this["place"+nilaiHasilAcak].gotoAndStop(2);
				pindahKeP2();
			}
			//end winAiO()
		}

		function pindahKeP1(){
			this["place"+nilaiHasilAcak]. buttonMode = false;
			this["place"+nilaiHasilAcak]. removeEventListener(MouseEvent.CLICK, placeClicked);
			//giliran player 1
			turn = a.text;
			statusTxt.text = "Giliran " +  a.text;			
			cekMenang();
		}
		function pindahKeP2(){
			this["place"+nilaiHasilAcak]. buttonMode = false;
			this["place"+nilaiHasilAcak]. removeEventListener(MouseEvent.CLICK, placeClicked);			
			//giliran player 2
			turn = b.text;
			statusTxt.text = "Giliran " + b.text ;
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
				statusTxt.text = "Giliran " +  a.text;			
				cekMenang();

				// berhentiin timer
				timergiliran.removeEventListener(TimerEvent.TIMER_COMPLETE, setKomputerO); 
				timergiliran.removeEventListener(TimerEvent.TIMER_COMPLETE, setKomputerX); 

				timeracak.removeEventListener(TimerEvent.TIMER_COMPLETE, setKomputerX);
				timeracak.removeEventListener(TimerEvent.TIMER_COMPLETE, setKomputerO);
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
				statusTxt.text = "Giliran " + b.text ;
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