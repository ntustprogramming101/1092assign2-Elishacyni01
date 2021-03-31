PImage bg, gameover, title, startHovered, startNormal, restartHovered, restartNormal;
PImage cabbage, life, soldier, soil;
PImage groundhogIdle, groundhogDown, groundhogLeft, groundhogRight;

float soldierX, soldierY;
float soldierXSpeed;

float cabbageX, cabbageY;

float groundhogX, groundhogY;

final int LIFE_ONE = 1;
final int LIFE_TWO = 2;
final int LIFE_THREE = 3;
int gameLife = LIFE_TWO;

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_OVER = 2;
int gameState = GAME_START;

boolean cabbageAppear = true;

final int BUTTON_TOP = 360;
final int BUTTON_BOTTOM = 420;
final int BUTTON_LEFT = 248;
final int BUTTON_RIGHT = 392;

void setup() {
	size(640, 480, P2D);

	bg = loadImage("img/bg.jpg");
  gameover = loadImage("img/gameover.jpg");
  title = loadImage("img/title.jpg");
  startHovered = loadImage("img/startHovered.png");
  startNormal = loadImage("img/startNormal.png");
  restartHovered = loadImage("img/restartHovered.png");
  restartNormal = loadImage("img/restartNormal.png");
  cabbage = loadImage("img/cabbage.png");
  life = loadImage("img/life.png");
  soldier = loadImage("img/soldier.png");
  soil = loadImage("img/soil.png");
  groundhogIdle = loadImage("img/groundhogIdle.png");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  groundhogRight = loadImage("img/groundhogRight.png");
  
  // Soldier
  soldierX = -80;
  soldierY = floor(random(2,6))*80;
  soldierXSpeed = 4;
  
  // Cabbage
  cabbageX = floor(random(8))*80;
  cabbageY = floor(random(2,6))*80;
  
  
  // Groundhog
  groundhogX = 320;
  groundhogY = 80;
}

void draw() 
{
	// Switch Game State
  switch(gameState)
  {
    case GAME_START:
      background(title);
      if(mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM)
      {
        image(startHovered, BUTTON_LEFT, BUTTON_TOP);
        if(mousePressed)
        {
          gameState = GAME_RUN;
        }
      }else
      {
        image(startNormal, BUTTON_LEFT, BUTTON_TOP);
      }
    break;
    
    case GAME_RUN:
  	  cabbageAppear = true;
      
      // Gamelife
      switch(gameLife)
      {
        case LIFE_ONE:
          background(bg);
          image(life, 10, 10);
          break;
        case LIFE_TWO:
          background(bg);
          image(life, 10, 10);
          image(life, 80, 10);
          break;
        case LIFE_THREE:
          background(bg);
          image(life, 10, 10);
          image(life, 80, 10);
          image(life, 150, 10);
          break;
      }
      
      // Soil
      image(soil, 0, 160);
      
      // Lawn
      noStroke();
      fill(124,204,25);
      rect(0,145,640,15);
      
      // Sun
      strokeWeight(5);
      stroke(255,255,0);
      fill(253,184,19);
      ellipse(590,50,120,120);
      
      // Groundhog
      image(groundhogIdle, groundhogX, groundhogY);
    	
      // Soldier
      // soldier random appear
      image(soldier, soldierX, soldierY);
      
      // soldier left to right
      soldierX += soldierXSpeed;
      if(soldierX >= 640) soldierX = -80;
      
      // Groundhog bump into soldier
      if(groundhogX < soldierX + 80 && groundhogX + 80 > soldierX){
        if(groundhogY < soldierY + 80 && groundhogY + 80 > soldierY){
          if(gameLife == LIFE_ONE){
            groundhogX = 320;
            groundhogY = 80;
            gameState = GAME_OVER;
          }
          if(gameLife == LIFE_TWO){
            groundhogX = 320;
            groundhogY = 80;
            gameLife = LIFE_ONE;
          }
          if(gameLife == LIFE_THREE){
            groundhogX = 320;
            groundhogY = 80;
            gameLife = LIFE_TWO;
          }
        }
      }
      
      // Groundhog eat cabbage
      if(groundhogX < cabbageX + 80 && groundhogX + 80 > cabbageX){
        if(groundhogY < cabbageY + 80 && groundhogY + 80 > cabbageY){
          if(gameLife == LIFE_ONE){
            gameLife = LIFE_TWO;
            cabbageAppear = false;
          }
          else if(gameLife == LIFE_TWO){
            gameLife = LIFE_THREE;
            cabbageAppear = false;
          }
        }
      }
      
      // Cabbage
      if(cabbageAppear == true){
        image(cabbage, cabbageX, cabbageY);
      }
      if(cabbageAppear == false){
        cabbageX = -80;
        cabbageY = -80;
        image(cabbage, cabbageX, cabbageY);
      }
   break;
   
   case GAME_OVER:
      background(gameover);
      if(mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM)
      {
        image(restartHovered, BUTTON_LEFT, BUTTON_TOP);
        if(mousePressed)
        {
          //reset
          // Soldier
          soldierX = -80;
          soldierY = floor(random(2,6))*80;
          soldierXSpeed = 4;
          // Cabbage
          cabbageX = floor(random(8))*80;
          cabbageY = floor(random(2,6))*80;
          
          gameState = GAME_RUN;
          gameLife = LIFE_TWO;
          groundhogX = 320;
          groundhogY = 80;

        }
      }else
      {
        image(restartNormal, BUTTON_LEFT, BUTTON_TOP);
      }
   break;
  }
}

void keyPressed()
{
  if (key == CODED) 
  {
    switch (keyCode)
    {
      case DOWN:
        if(groundhogY >= 400){
          groundhogY = 400;
        }else{
          groundhogY += 80;
        }
        break;
        
      case LEFT:
        if(groundhogX <= 0){
          groundhogX = 0;
        }else{
          groundhogX -= 80;
        }
        break;
        
      case RIGHT:
        if(groundhogX >= 560){
          groundhogX = 560;
        }else{
          groundhogX += 80;
        }
        break;
    }
  }
}

void keyReleased(){
}
