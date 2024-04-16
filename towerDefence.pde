ArrayList<Towers> towers = new ArrayList<Towers>();
ArrayList<TowerShots> tShots = new ArrayList<TowerShots>();
ArrayList<EnemyShots> eShots = new ArrayList<EnemyShots>();
ArrayList<Enemies> enemies = new ArrayList<Enemies>();
ArrayList<Explosion> explosion = new ArrayList<Explosion>();

float power = 1;//muliplier for power so enemies get stronger in order to add challenge

int boxSize = 100;
int life = 100;
int money = 100;
int enemyCooldown = 7500;//how long between enemies 
int enemyTimer = enemyCooldown;
int waveCooldown = 60000;//how long between waves in milliseconds
int waveTimer = 0;
int wave;//how many waves have passed
int difficulty = 1;//as time goes by this will increase, starts at 1
int shopScroll;
int shopCooldown[] = {0,1,2,3,4,5,6,7,8,9,10,110};
int shopTimer[] = {0,1,2,3,4,5,6,7,8,9,10,11};

boolean gameStarted;
boolean selling;

PImage [] towerImage = new PImage[21];
PImage [] enemyImage = new PImage[21];
PImage [] towerShotImage = new PImage[21];
PImage [] enemyShotImage = new PImage[21];

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
  towerImage[0] = loadImage("smallFry.png");//basic
  towerImage[0].resize(boxSize, 0);
  towerImage[1] = loadImage("CatFish.png");
  towerImage[1].resize(boxSize, 0);
  towerImage[2] = loadImage("coral.png");//wall
  towerImage[2].resize(boxSize, 0);
  towerImage[3] = loadImage("cannonFish.png");
  towerImage[3].resize(boxSize, 0);
  towerImage[4] = loadImage("blueFish.png");
  towerImage[4].resize(boxSize, 0);
  towerImage[5] = loadImage("yellowFishRight.png");
  towerImage[5].resize(boxSize, 0);
  towerImage[6] = loadImage("heartFish.png");
  towerImage[6].resize(boxSize, 0);
  towerImage[7] = loadImage("arrow.png");
  towerImage[7].resize(boxSize, 0);
  towerImage[8] = loadImage("waterMine.png");
  towerImage[8].resize(boxSize, 0);
  towerImage[9] = loadImage("twoYellowFish.png");
  towerImage[9].resize(boxSize, 0);
  towerImage[10] = loadImage("iceCubeFish.png");
  towerImage[10].resize(boxSize, 0);
  towerImage[11] = loadImage("dummy.png");
  towerImage[11].resize(boxSize, 0);
  towerImage[12] = loadImage("dummy.png");
  towerImage[12].resize(boxSize, 0);
  towerImage[13] = loadImage("dummy.png");
  towerImage[13].resize(boxSize, 0);
  towerImage[14] = loadImage("dummy.png");
  towerImage[14].resize(boxSize, 0);
  towerImage[15] = loadImage("dummy.png");
  towerImage[15].resize(boxSize, 0);
  towerImage[20] = loadImage("dummy.png");
  towerImage[20].resize(boxSize, 0);
  
  towerShotImage[0] = loadImage("waterDropShot.png");//basic
  towerShotImage[0].resize(boxSize/2, 0);
  towerShotImage[1] = loadImage("yarnBall.png");//moderate
  towerShotImage[1].resize(boxSize/2, 0);
  towerShotImage[2] = loadImage("dummy.png");//wall
  towerShotImage[2].resize(boxSize/2, 0);
  towerShotImage[3] = loadImage("bomb.png");//cannon
  towerShotImage[3].resize(boxSize/2, 0);
  towerShotImage[4] = loadImage("arrowRight.png");//fast
  towerShotImage[4].resize(boxSize/2, 0);
  towerShotImage[5] = loadImage("yellowFishRight.png");//producer
  towerShotImage[5].resize(boxSize/2, 0);
  towerShotImage[6] = loadImage("dummy.png");//healing wall
  towerShotImage[6].resize(boxSize/2, 0);
  towerShotImage[7] = loadImage("waterBlast.png");
  towerShotImage[7].resize(boxSize/2, 0);
  towerShotImage[8] = loadImage("dummy.png");//mine
  towerShotImage[8].resize(boxSize/2, 0);
  towerShotImage[9] = loadImage("dummy.png");//better producer
  towerShotImage[9].resize(boxSize/2, 0);
  towerShotImage[10] = loadImage("iceCube.png");//slow down
  towerShotImage[10].resize(boxSize/2, 0);
  towerShotImage[11] = loadImage("dummy.png");
  towerShotImage[11].resize(boxSize/2, 0);
  towerShotImage[12] = loadImage("dummy.png");
  towerShotImage[12].resize(boxSize/2, 0);
  towerShotImage[13] = loadImage("dummy.png");
  towerShotImage[13].resize(boxSize/2, 0);
  towerShotImage[14] = loadImage("dummy.png");
  towerShotImage[14].resize(boxSize/2, 0);
  towerShotImage[15] = loadImage("dummy.png");
  towerShotImage[15].resize(boxSize/2, 0);
  towerShotImage[16] = loadImage("dummy.png");
  towerShotImage[16].resize(boxSize/2, 0);
  towerShotImage[17] = loadImage("dummy.png");
  towerShotImage[17].resize(boxSize/2, 0);
  towerShotImage[18] = loadImage("dummy.png");
  towerShotImage[18].resize(boxSize/2, 0);
  towerShotImage[19] = loadImage("dummy.png");
  towerShotImage[19].resize(boxSize/2, 0);
  towerShotImage[20] = loadImage("dummy.png");
  towerShotImage[20].resize(boxSize/2, 0);
  
  enemyImage[0] = loadImage("keese.png");//basic
  enemyImage[0].resize(boxSize, 0);
  enemyImage[1] = loadImage("ganon.png");
  enemyImage[1].resize(boxSize, 0);
  enemyImage[2] = loadImage("piranhaLeft.png");
  enemyImage[2].resize(boxSize, 0);
  enemyImage[3] = loadImage("dekuScrub.png");//wall
  enemyImage[3].resize(boxSize, 0);
  enemyImage[4] = loadImage("bombGuy.png");
  enemyImage[4].resize(boxSize, 0);
  enemyImage[5] = loadImage("PurpleDragon.png");
  enemyImage[5].resize(boxSize, 0);
  enemyImage[6] = loadImage("dummy.png");
  enemyImage[6].resize(boxSize, 0);
  enemyImage[7] = loadImage("dummy.png");
  enemyImage[7].resize(boxSize, 0);
  
  enemyShotImage[5] = loadImage("fireCharge.png");
  enemyShotImage[5].resize(boxSize/2, 0);
  
  explosionPic = loadImage("explosion.png");
  
  floorTile = loadImage("waterTile2.png");
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
  handleEnemyShots();
  handleExplosions();
  handleForeground();
  handleShop();
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
  if(key == '2')
  {
    difficulty ++;
  }
  if(key == '1')
  {
    difficulty --;
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
      money += t.price * (t.health/t.maxHealth);
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
      if(money >= towers.get(i).price && !towers.get(i).bought && towers.get(i).grabbed && mouseOnGrid() && towers.get(i).onGrid() )//buys towers
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

void handleShop()
{
  for(int i = 0; i < 12; i++)
  {
    if(millis() > shopTimer[i])
    {
      shopTimer[i] = millis() + shopCooldown[i];
    }
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
        towers.add( new Towers(x, y, j+shopScroll));
        
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
    e.shoot();
  }
  
  if(millis() > enemyTimer && life > 0)//enemy spawn timer
  {
    enemies.add(new Enemies(width + random(50,100),random(0,height-boxSize),int(random(0,difficulty))));
    enemyTimer = millis() + enemyCooldown;
    if(enemyCooldown > 1000)//shorten timer making enemies spawn faster
    {
      enemyCooldown -= enemyCooldown / 45;
      println(enemyCooldown);
    }
    else if(enemyCooldown <= 1000 && difficulty < 8)//increases difficulty whenever the timer is too fast
    {
      println("increasing difficulty, current time" + millis()/1000);
      enemyCooldown = 7500;
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

void handleEnemyShots()
{
  for(EnemyShots e: eShots)
 {
   e.moveShot();
   e.drawShot();
   e.checkForHit();
 }
 for(int i = 0; i < eShots.size(); i++)//removes when not active
  {
    if(!eShots.get(i).active)
    {
      eShots.remove(i);
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
    if(dist(mouseX,mouseY,towers.get(i).xPos,towers.get(i).yPos) < (towers.get(i).size/2) + boxSize*0.21)
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
void mouseWheel(MouseEvent event)
{
  float e = event.getCount();
  if (e > 0  && shopScroll < 4)
  {
    shopScroll +=2;
    for(int i = 0; i < towers.size(); i++)
    {
      if(!towers.get(i).bought)
      {
        towers.get(i).active = false;
      }
    }
  }
  if (e < 0 && shopScroll > 0)
  {
    shopScroll-=2;
    for(int i = 0; i < towers.size(); i++)
    {
      if(!towers.get(i).bought)
      {
        towers.get(i).active = false;
      }
    }
  }
  
}
