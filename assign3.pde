final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;
final int SOIL = 80; // height and width

//groundhog
PImage groundhogIdle;
PImage groundhogDown;
PImage groundhogLeft;
PImage groundhogRight;
int groundhogX = 320;
int groundhogY = 80;
int gW=80; //groundhog width
int gH=80; //groundhog height
int groundhogMoveY;
int groundhogMoveX;

//boolean
boolean downPressed=false;
boolean leftPressed=false;
boolean rightPressed=false;
//time
float nowTime;
float lastTime;


PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage skyImg, soil8x24;
PImage lifeImg;
PImage soil0,soil1,soil2,soil3,soil4,soil5;
PImage stone1,stone2;


// For debug function; DO NOT edit or remove this!
int playerHealth = 0;
float cameraOffsetY = 0;
boolean debugMode = false;

void setup() {
	size(640, 480, P2D);
	// Enter your setup code here (please put loadImage() here or your game will lag like crazy)
	skyImg = loadImage("img/bg.jpg");
	title = loadImage("img/title.jpg");
	gameover = loadImage("img/gameover.jpg");
	startNormal = loadImage("img/startNormal.png");
	startHovered = loadImage("img/startHovered.png");
	restartNormal = loadImage("img/restartNormal.png");
	restartHovered = loadImage("img/restartHovered.png");
	//soil8x24 = loadImage("img/soil8x24.png");
  lifeImg = loadImage("img/life.png");
  
  //stone 
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");
  
  //soil
  soil0 = loadImage("img/soil0.png");
  soil1 = loadImage("img/soil1.png");
  soil2 = loadImage("img/soil2.png");
  soil3 = loadImage("img/soil3.png");
  soil4 = loadImage("img/soil4.png");
  soil5 = loadImage("img/soil5.png");
  
  //groundhog
  groundhogDown=loadImage("img/groundhogDown.png");
  groundhogIdle=loadImage("img/groundhogIdle.png");
  groundhogLeft=loadImage("img/groundhogLeft.png");
  groundhogRight=loadImage("img/groundhogRight.png");

}

void draw() {
    /* ------ Debug Function ------ 

      Please DO NOT edit the code here.
      It's for reviewing other requirements when you fail to complete the camera moving requirement.

    */
    if (debugMode) {
      pushMatrix();
      translate(0, cameraOffsetY);
    }
    /* ------ End of Debug Function ------ */

    
	switch (gameState) {

		case GAME_START: // Start Screen
		image(title, 0, 0);

		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(startHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
			}

		}else{

			image(startNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;

	
   	case GAME_RUN: // In-Game
     //sky
    image(skyImg,0,0); 

		// Sun
	    stroke(255,255,0);
	    strokeWeight(5);
	    fill(253,184,19);
	    ellipse(590,50,120,120);

		// Grass
		fill(124, 204, 25);
		noStroke();
		rect(0, 160 - GRASS_HEIGHT, width, GRASS_HEIGHT);

		// Soil - REPLACE THIS PART WITH YOUR LOOP CODE!
    for(int h=SOIL*2 ; h<SOIL*6 ; h+=SOIL){
      for(int w=0 ; w<width ; w+=SOIL){
        image(soil0,w,h);
      }
    }
     for(int h=SOIL*6 ; h<SOIL*10 ; h+=SOIL){
      for(int w=0 ; w<width ; w+=SOIL){
        image(soil1,w,h);
      }
    }
     for(int h=SOIL*10 ; h<SOIL*14 ; h+=SOIL){
      for(int w=0 ; w<width ; w+=SOIL){
        image(soil2,w,h);
      }
    }
     for(int h=SOIL*14 ; h<SOIL*18 ; h+=SOIL){
      for(int w=0 ; w<width ; w+=SOIL){
        image(soil3,w,h);
      }
    }
     for(int h=SOIL*18 ; h<SOIL*22 ; h+=SOIL){
      for(int w=0 ; w<width ; w+=SOIL){
        image(soil4,w,h);
      }
    }
     for(int h=SOIL*22 ; h<SOIL*26 ; h+=SOIL){
      for(int w=0 ; w<width ; w+=SOIL){
        image(soil5,w,h);
      }
    }
    
//stone1
//1-8
    float x1 = 0;
    float y1 = SOIL*2;
    for(int i=0 ; i<8 ; i++){
        x1=SOIL*i;
        image(stone1,x1,y1);
        y1+=SOIL;
    }
//9-16    
    for(int x2=0 ; x2<width ; x2+=SOIL){
      for(int y2=SOIL*10 ; y2<SOIL*18 ; y2+=SOIL){
        image(stone1,x2,y2);
      }
    }
    //cover image(soil2)//3 floor left
    float s1 = 0;
    float z1 = SOIL*10;
    for(int i=0 ; i<4 ; i++){
        s1=SOIL*i;
        image(soil2,s1,z1);
        z1+=SOIL;
    }
    float s2 = 0;
    float z2 = SOIL*13;
    for(int i=0 ; i<4 ; i++){
        s2=SOIL*i;
        image(soil2,s2,z2);
        z2-=SOIL;
    }
    //cover image(soil2)//3 floor right
    float s3 = SOIL*4;
    float z3 = SOIL*10;
    for(int i=0 ; i<4 ; i++){
        s3 = SOIL*4+SOIL*i;
        image(soil2,s3,z3);
        z3 += SOIL;
    }
    float s4 = 0;
    float z4 = SOIL*13;
    for(int i=0 ; i<4 ; i++){
        s4 = SOIL*4 + SOIL*i;
        image(soil2,s4,z4);
        z4 -= SOIL;
    }
    //cover image(soil2)//4 floor left
    float s5 = 0;
    float z5 = SOIL*14;
    for(int i=0 ; i<4 ; i++){
        s5 = SOIL*i;
        image(soil3,s5,z5);
        z5 += SOIL;
    }
    float s6 = 0;
    float z6 = SOIL*17;
    for(int i=0 ; i<4 ; i++){
        s6 = SOIL*i;
        image(soil3,s6,z6);
        z6 -= SOIL;
    }
    //cover image(soil2)//4 floor right
    float s7 = SOIL*4;
    float z7 = SOIL*14;
    for(int i=0 ; i<4 ; i++){
        s7 = SOIL*4+SOIL*i;
        image(soil3,s7,z7);
        z7 += SOIL;
    }
    float s8 = SOIL*4;
    float z8 = SOIL*17;
    for(int i=0 ; i<4 ; i++){
        s8 = SOIL*4 + SOIL*i;
        image(soil3,s8,z8);
        z8 -= SOIL;
    }
//stone1+2
    
    /* for(int x=0 ; x<width ; x+=SOIL){
      for(int y=SOIL*18 ; y<SOIL*26 ; y+=SOIL){

        image(stone1,x,y);

      }
    }
    */

// Player
    //groundhog moving
     if(downPressed){
       if( groundhogMoveY <= groundhogY ){
         groundhogMoveY+=80/15.0;
         image(groundhogDown,groundhogX,groundhogMoveY);
         nowTime = millis();
       }else{
         downPressed = false;
       }
     }
     else if(leftPressed){
       if( groundhogMoveX>=groundhogX ){
         groundhogMoveX-=80/15.0;
         image(groundhogLeft,groundhogMoveX,groundhogY);
         
       }else{
         leftPressed = false;
       }
     }
     else if(rightPressed){
       if( groundhogMoveX<=groundhogX ){
         groundhogMoveX+=80/15.0;
         image(groundhogRight,groundhogMoveX,groundhogY);
       } else{
          rightPressed = false;
       }
     }
     else{
       image(groundhogIdle,groundhogX,groundhogY);

    // Health UI
    if(playerHealth==5){
       image(lifeImg,10,10); //1heart
       image(lifeImg,80,10); //2heart
       image(lifeImg,150,10); //3heart
       image(lifeImg,220,10); //4heart
       image(lifeImg,290,10); //5heart
    }   
    if(playerHealth==4){
       image(lifeImg,10,10); //1heart
       image(lifeImg,80,10); //2heart
       image(lifeImg,150,10); //3heart
       image(lifeImg,220,10); //4heart
    }        
    if(playerHealth==3){
       image(lifeImg,10,10); //1heart
       image(lifeImg,80,10); //2heart
       image(lifeImg,150,10); //3heart
     }
     if(playerHealth==2){
       image(lifeImg,10,10); //1heart
       image(lifeImg,80,10); //2heart
     }
     if(playerHealth==1){
       image(lifeImg,10,10); //1heart
     }
    
 }
		break;

		case GAME_OVER: // Gameover Screen
		image(gameover, 0, 0);
		
		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
				// Remember to initialize the game here!
			}
		}else{

			image(restartNormal, START_BUTTON_X, START_BUTTON_Y);
     
		}
		break;
		
	}

    // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
    if (debugMode) {
        popMatrix();
    }
}

void keyPressed(){
	// Add your moving input code here
  nowTime = millis(); 
  if(key==CODED){
    switch(keyCode){
      case DOWN:
      if(nowTime - lastTime > 250){
         downPressed=true;
         groundhogMoveY = groundhogY; //start position
         groundhogY += SOIL;
         lastTime = millis();
         
       }
      break;
      
      case LEFT:
      if(nowTime - lastTime > 250){
         groundhogMoveX = groundhogX; 
         groundhogX -= SOIL;
         leftPressed=true;
         lastTime = millis();
        
      }
      break;
      
      case RIGHT:
      if(nowTime - lastTime > 250){
         groundhogMoveX = groundhogX;
         rightPressed = true;
         groundhogX += SOIL;
         lastTime = millis();
         
      }     
      break;
    }
 }
	// DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
    switch(key){
      case 'w':
      debugMode = true;
      cameraOffsetY += 25;
      break;

      case 's':
      debugMode = true;
      cameraOffsetY -= 25;
      break;

      case 'a':
      if(playerHealth > 0) playerHealth --;
      break;

      case 'd':
      if(playerHealth < 5) playerHealth ++;
      break;
    }
}

void keyReleased(){
  if(key==CODED){
    switch(keyCode){
      case DOWN:
      downPressed=false;
      break;
      
      case LEFT:
      leftPressed=false;
      break;
      
      case RIGHT:
      rightPressed=false;
      break;
     }
 }
}
