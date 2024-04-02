ArrayList<Towers> towers = new ArrayList<Towers>();
ArrayList<TowerShots> tShots = new ArrayList<TowerShots>();
ArrayList<Enemies> enemies = new ArrayList<Enemies>();
ArrayList<Explosion> explosion = new ArrayList<Explosion>();

float power = 1;//muliplier for power so enemies get stronger in order to add challenge

int boxSize = 100;
int life = 100;
int money = 100;
int enemyCooldown = 10000;//how long between enemies 
int enemyTimer = enemyCooldown;
int waveCooldown = 60000;//how long between waves in milliseconds
int waveTimer = 0;
int wave;//how many waves have passed
int difficulty = 1;//as time goes by this will increase, starts at 1

boolean gameStarted;
boolean selling;

PImage [] towerImage = new PImage[8];
PImage [] enemyImage = new PImage[8];
PImage [] towerShotImage = new PImage[8];

PImage floorTile;
PImage warning;

PImage explosionPic;

UI UI;

//boolean mouseOnGrid();

void setup()
{
  size(1200,800);
  imageMode(CENTER);
  UI = new UI();
  //noSmooth();
  //fullScreen();
  //noStroke();
  towers.add( new Towers(width - 225, 180,0));//do not remove this, it will mess up the shop
  towerImage[0] = loadImage("PurpleDragonRight.png");//basic
  towerImage[0].resize(boxSize, 0);
  towerImage[1] = loadImage("cosmoPixel.png");
  towerImage[1].resize(boxSize, 0);
  towerImage[2] = loadImage("cobbleColor.png");//wall
  towerImage[2].resize(boxSize, 0);
  towerImage[3] = loadImage("oldMan.png");
  towerImage[3].resize(boxSize, 0);
  towerImage[4] = loadImage("blueFish.png");
  towerImage[4].resize(boxSize, 0);
  towerImage[5] = loadImage("yellowFishRight.png");
  towerImage[5].resize(boxSize, 0);
  towerImage[6] = loadImage("heartContainer.png");
  towerImage[6].resize(boxSize, 0);
  towerImage[7] = loadImage("arrow.png");
  towerImage[7].resize(boxSize, 0);
  
  towerShotImage[0] = loadImage("dekuNut.png");//basic
  towerShotImage[0].resize(boxSize/2, 0);
  towerShotImage[1] = loadImage("dekuBall.png");//moderate
  towerShotImage[1].resize(boxSize/2, 0);
  towerShotImage[2] = loadImage("cobbleColor.png");//wall
  towerShotImage[2].resize(boxSize/2, 0);
  towerShotImage[3] = loadImage("bomb.png");//cannon
  towerShotImage[3].resize(boxSize/2, 0);
  towerShotImage[4] = loadImage("arrowRight.png");//fast
  towerShotImage[4].resize(boxSize/2, 0);
  towerShotImage[5] = loadImage("yellowFishRight.png");//producer
  towerShotImage[5].resize(boxSize/2, 0);
  towerShotImage[6] = loadImage("heartContainer.png");//healing wall
  towerShotImage[6].resize(boxSize/2, 0);
  towerShotImage[7] = loadImage("wind.png");
  towerShotImage[7].resize(boxSize/2, 0);
  
  enemyImage[0] = loadImage("keese.png");//basic
  enemyImage[0].resize(boxSize, 0);
  enemyImage[1] = loadImage("ganon.png");
  enemyImage[1].resize(boxSize, 0);
  enemyImage[2] = loadImage("dekuScrub.png");//wall
  enemyImage[2].resize(boxSize, 0);
  enemyImage[3] = loadImage("piranhaLeft.png");
  enemyImage[3].resize(boxSize, 0);
  enemyImage[4] = loadImage("bombGuy.png");
  enemyImage[4].resize(boxSize, 0);
  enemyImage[5] = loadImage("dummy.png");
  enemyImage[5].resize(boxSize, 0);
  enemyImage[6] = loadImage("dummy.png");
  enemyImage[6].resize(boxSize, 0);
  enemyImage[7] = loadImage("dummy.png");
  enemyImage[7].resize(boxSize, 0);
  
  explosionPic = loadImage("explosion.png");
  
  floorTile = loadImage("grassTile3.png");
  floorTile.resize(boxSize,0);
  
  warning = loadImage("warningIcon.png");
  warning.resize(int(boxSize*0.85),0);
}
void draw()
{
  handleBackground();
  handleEnemies();
  handleTowers();
  handleTowerShot();
  handleExplosions();
  handleForeground();

}
void keyPressed()
{
  if(key == 'e')
  {
    enemies.add(new Enemies(mouseX,mouseY,int(random(0,difficulty))));
  }
  if(key == 'E')//wave
  {
    sendWave(10);
  }
  if(key == 't' && !spaceOccupied())
  {
    towers.add(new Towers(mouseX,mouseY,1));
  }
  if(key == 'M')
  {
    money += 250;
  }
  if(key == 'B')
  {
    explosion.add( new Explosion(mouseX,mouseY,2));
  }
  if(key == 'V')
  {
    explosion.add( new Explosion(mouseX,mouseY,1));
  }
  if(key == 'X')
  {
    for(int i = 0; i < 25; i++)
      explosion.add( new Explosion(random(width),random(height),0));
  }
  if(key == 'P')
  {
    power+=0.1;
    println(power);
  }
}
void mousePressed()
{
  for(Towers t: towers)
  {
    if(dist(mouseX,mouseY,t.xPos,t.yPos) < (t.size/2) && (mouseButton == LEFT) && !t.placed)//grabbing towers
    {
      t.grabbed = true;
    }
    if(dist(mouseX,mouseY,t.xPos,t.yPos) < (t.size/2) && (mouseButton == LEFT) && t.placed && selling)
    {
      t.active = false;
      money += t.price*0.90;
    }
  }
  sellingTowers();
}
void mouseReleased()
{
  for(Towers t: towers)//dropping towers
  {
    for(int i = 0; i < towers.size(); i++)
    {
      if(money >= towers.get(i).price && !towers.get(i).bought && towers.get(i).grabbed && mouseOnGrid() && towers.get(i).onGrid())//buys towers
      {
        money -= towers.get(i).price;
        towers.get(i).produceTimer = millis() + towers.get(i).produceCooldown;
        towers.get(i).bought = true;
        towers.get(i).placed = true;
        selling = false;
      }
      else if( !towers.get(i).bought && towers.get(i).grabbed && !mouseOnGrid())//removes tower if not bought and not on the board
      {
        println("not on board");
        towers.get(i).active = false;
        return;
      }
    }
    t.grabbed = false;
  }
}
void handleTowers()
{
  for(Towers t: towers)
  {
    t.drawTowers();
    t.snapToGrid();
    t.attack();
    t.moveTowers();
    t.returnToBoard();
    t.produce();
    t.regenHealth();
  }
  for(int i = 0; i < towers.size(); i++)
  {
    if(!towers.get(i).active)
    {
      towers.remove(i);
    }
    for(int j = 0; j < 8; j++)
    {
      if(!shopStocked(j) && (mouseButton != LEFT))//restocks shop
      {
        int x = (width-225)+(j%2*150);
        int y = 180+(150*(j/2));
        towers.add( new Towers(x, y, j));

      }
    }
  }
}
void handleBackground()
{
  UI.drawBackground();
}

void handleForeground()
{
  UI.drawInterface();
  UI.drawInfo();
}
void handleEnemies()
{
  for(Enemies e: enemies)
  {
    e.drawEnemies();
    e.moveEnemies();
    e.hitTowers();
  }
  
  if(millis() > enemyTimer && life > 0)//enemy spawn timer
  {
    enemies.add(new Enemies(width + random(50,100),random(0,height-boxSize),int(random(0,difficulty))));
    enemyTimer = millis() + enemyCooldown;
    if(enemyCooldown > 500)//shorten timer making enemies spawn faster
    {
      enemyCooldown -= enemyCooldown / 50;
      println(enemyCooldown);
    }
    else if(enemyCooldown <= 500 && difficulty < 8)//increases difficulty whenever the timer is too fast
    {
      println("increasing difficulty");
      enemyCooldown = 10000;
      difficulty += 1;
    }
    if( difficulty >= 8)
    {
      println("increasing power: " + power);
      power += 0.005;
    }
    
  }
  if(millis() > waveTimer && life > 0)//sends waves
  {
    waveTimer += waveCooldown;
    println("INCOMING WAVE " + millis()/waveCooldown);
    sendWave(millis()/waveCooldown);
    wave ++;
  }
  if(life <= 0)//lose screen
  {
    enemies.clear();
    push();
    fill(255);
    textSize(25);
    textAlign(CENTER);
    text("YOU LOSE",width/2,height/2);
    pop();
  }
  
  for(int i = 0; i < enemies.size(); i++)
  {
    if(!enemies.get(i).active)//remove enemies if they are not active
    {
      enemies.remove(i);
    }
  }
}

void handleTowerShot()
{
 for(TowerShots t: tShots)
 {
   t.moveShot();
   t.drawShot();
   t.checkForHit();
 }
 for(int i = 0; i < tShots.size(); i++)//removes when not active
  {
    if(!tShots.get(i).active)
    {
      tShots.remove(i);
    }
  }
}

void handleExplosions()
{
  for(int i = 0; i < explosion.size(); i++)
  {
    explosion.get(i).drawExplosion();
    explosion.get(i).moveExplosion();
    explosion.get(i).checkForHit();
    if(!explosion.get(i).active)//remove enemies if they are not active
    {
      explosion.remove(i);
    }
  } 
}

void sendWave( int amount )//sends a wave of enemies based on the given number
{
  for(int i = 0; i < amount; i++)
    enemies.add(new Enemies(width + random(50,750),random(0,height-boxSize),int(random(0,difficulty))));
}

void sellingTowers()
{
  if(dist(mouseX,mouseY,width-350,height-50) < 45 && !selling)
  {
    selling = true;
    println("selling");
    return;
  }
  if(dist(mouseX,mouseY,width-350,height-50) < 45 && selling)
  {
    selling = false;
    println("not selling");
    return;
  }
}

boolean mouseOnGrid()
{
  if(mouseX < width-(boxSize*3) && mouseY < height-(boxSize*1))
  {
    return true;
  }
  return false;
}

boolean spaceOccupied()
{
  for(int i = 0; i < towers.size(); i++)
  {
    if(dist(mouseX,mouseY,towers.get(i).xPos,towers.get(i).yPos) < (towers.get(i).size/2) + boxSize*0.2)
    {
      //println("there is already a tower there");
      return true;
    }
  }
  return false;
}

boolean shopStocked( int x )
{
  for(int i = 0; i < towers.size(); i++)
  {
      int X = (width-225)+(x%2*150);
      int Y = 180+(150*(x/2));
      if(towers.get(i).xPos == X && towers.get(i).yPos == Y && !towers.get(i).bought)
      {
        x++;
        return true;
      }
  }
  return false;
}
