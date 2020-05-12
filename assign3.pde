final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2, HOG_STAND=3, HOG_RUN = 4;
int gameState = 0;
int hogState = 3;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;
final int SOIL = 80; // height and width




float slide = 0;
float slideY = 0;

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
boolean view = false;
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
   
    //view boolean
    if(view){
     pushMatrix();
     translate(0,slideY+5);
     if(slideY >= slide){
       slideY -= SOIL/15;
      }
    }

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
    for(int i=0; i<8; i++){
        image(stone1,SOIL*i,SOIL*2+SOIL*i);
    }
    
//9-16 
    for(int w=0; w<8; w++){
      if(w%4==1||w%4==2){
        for(int h=0; h<8; h++){
          if(h%4==0||h%4==3){
             image(stone1,w*SOIL,h*SOIL+SOIL*10);
          }
        }
      }
    }
    for(int w=0; w<8; w++){
      if(w%4==0||w%4==3){
        for(int h=0; h<8; h++){
          if(h%4==1||h%4==2){
             image(stone1,w*SOIL,h*SOIL+SOIL*10);
          }
        }
      }
    }
    
//17-24
//stone1
    for(int w=0; w<8; w++){
      if(w%3==1||w%3==2){
        for(int h=0; h<8; h++){
           if(h%3==0){
             image(stone1,w*SOIL,h*SOIL+SOIL*18);
           }
        }
      }
    }
    for(int w=0; w<8; w++){
      if(w%3==0||w%3==1){
        for(int h=0; h<8; h++){
           if(h%3==1){
             image(stone1,w*SOIL,h*SOIL+SOIL*18);
           }
        }
      }
    }
    for(int w=0; w<8; w++){
      if(w%3==0||w%3==2){
        for(int h=0; h<8; h++){
           if(h%3==2){
             image(stone1,w*SOIL,h*SOIL+SOIL*18);
           }
        }
      }
    }
//stone2
   for(int w=0; w<8; w++){
      if(w%3==2){
        for(int h=0; h<8; h++){
           if(h%3==0){
             image(stone2,w*SOIL,h*SOIL+SOIL*18);
           }
        }
      }
    }
    for(int w=0; w<8; w++){
      if(w%3==1){
        for(int h=0; h<8; h++){
           if(h%3==1){
             image(stone2,w*SOIL,h*SOIL+SOIL*18);
           }
        }
      }
    }
    for(int w=0; w<8; w++){
      if(w%3==0){
        for(int h=0; h<8; h++){
           if(h%3==2){
             image(stone2,w*SOIL,h*SOIL+SOIL*18);
           }
        }
      }
    }
 if (view) {
      popMatrix();
    }
    
// Player

     //boundary detection
      if (groundhogX>=width-gW){
        groundhogX=width-gW;
      }
      if (groundhogX<=0){
        groundhogX=0;
      }
      if (groundhogY>height-gW){
        groundhogY=height-gW;
      }
      if (groundhogY<SOIL){
        groundhogY=SOIL;
      }
      
    switch ( hogState ) {
    case HOG_STAND:    
      //groundhog moving
     if(downPressed){
         if(slideY>slide){
         image(groundhogDown, groundhogX, groundhogY);
        }else{
         downPressed = false;
         }
     }
     else if(leftPressed){
       if( groundhogMoveX>=groundhogX ){
        image(groundhogLeft,groundhogMoveX,groundhogY);
        groundhogMoveX-=80/15.0;
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
     }
     break;
     
     
     case HOG_RUN:
     if(downPressed){
       if (groundhogY < height) {
        if( groundhogMoveY <= groundhogY ){
         image(groundhogDown, groundhogX, groundhogMoveY);
         groundhogMoveY+=80/15.0;
        }else{
         downPressed = false;
         }
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
     }
     break;
    }
    // Health UI
  
      for(int h=0 ; h < playerHealth ; h++){
        image(lifeImg, 10+(70*h), 10);
      }
    
    
    
    /* //when game lose
     if(groundhogX+gW > soldierX && groundhogX < soldierX+sW){
        if(groundhogY+gH > soldierY && groundhogY < soldierY+sH ){ 
          groundhogX = 320;
          groundhogY = 80;
          playerHealth-=1;
          if(playerHealth==0){
            gameState = GAME_OVER;
          }
         }
      }*/

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
       
       view=true;
       groundhogMoveY = groundhogY; //start position
       slideY = slide;
      if(nowTime - lastTime > 250){
         downPressed=true;
         if(slide > SOIL*(-20)){
           hogState = HOG_STAND;
           slide -= SOIL;   
         }else{
           hogState = HOG_RUN;
           groundhogY += SOIL;
          }
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
