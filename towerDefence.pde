ArrayList<Towers> towers = new ArrayList<Towers>();
ArrayList<TowerShots> tShots = new ArrayList<TowerShots>();
ArrayList<Enemies> enemies = new ArrayList<Enemies>();

int boxSize = 100;
int life = 100;
int money = 300;

int enemyCooldown = 5000;
int enemyTimer = 0;

int waveCooldown = 30000;
int waveTimer = 000;

int difficulty;//as time goes by this will increase

boolean gameStarted;

boolean [] stocked = {false,false,false,false,false,false,false,false};

UI UI;

//boolean mouseOnGrid();

void setup()
{
  size(1200,800);
  
  UI = new UI();
  //fullScreen();
  //noStroke();
  towers.add( new Towers(width - 225, 180,1));
  towers.add( new Towers(width - 75, 180,1));
}
void draw()
{
  handleBackground();
  handleEnemies();
  
  handleTowerShot();
  handleForeground();
  handleTowers();
}
void keyPressed()
{
  if(key == 'e')
  {
    enemies.add(new Enemies(mouseX,mouseY,0));
  }
  if(key == 'E')//wave
  {
    sendWave(10);
  }
  if(key == 't' && !spaceOccupied())
  {
    towers.add(new Towers(mouseX,mouseY,1));
  }
}
void mousePressed()
{
  for(Towers t: towers)
  {
    if(dist(mouseX,mouseY,t.xPos,t.yPos) < t.size/2 && (mouseButton == LEFT))//grabbing towers
    {
      t.grabbed = true;
    }
  }
  
}
void mouseReleased()
{
  for(Towers t: towers)//dropping towers
  {
    for(int i = 0; i < towers.size(); i++)
    {
      if(money >= 50 && !towers.get(i).bought && towers.get(i).grabbed ) //mouseOnGrid())
      {
        money -= 50;
        towers.get(i).bought = true;
        
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
  }
  for(int i = 0; i < towers.size(); i++)
  {
    if(!towers.get(i).active)
    {
      towers.remove(i);
    }
    for(int j = 0; j < 8; j++)
    {
      if(!shopStocked())
      {
        int x = (width-225)+(j%2*150);
        int y = 180+(150*(j/2));
        towers.add( new Towers(x, y, 1));
        stocked[j] = true;
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
    enemies.add(new Enemies(width + random(50,100),random(0,height-boxSize),0));
    enemyTimer = millis() + enemyCooldown;
    if(enemyCooldown > 100)//shorten timer making enemies spawn faster
    {
      enemyCooldown -= enemyCooldown / 50;
      println(enemyCooldown);
      
    }
    if(millis() > waveTimer)
    {
      waveTimer += waveCooldown;
      println("INCOMING WAVE");
      sendWave(millis()/waveCooldown);
    }
  }
  if(life <= 0)//lose screen
  {
    enemies.clear();
    push();
    fill(0);
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

void sendWave( int amount )//sends a wave of enemies based on the given number
{
  for(int i = 0; i < amount; i++)
    enemies.add(new Enemies(width + random(50,1000),random(0,height-boxSize),0));
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
    if(dist(mouseX,mouseY,towers.get(i).xPos,towers.get(i).yPos) < (towers.get(i).size/2)+10)
    {
      //println("there is already a tower there");
      return true;
    }
  }
  return false;
}

boolean shopStocked( )
{
  for(int i = 0; i < towers.size(); i++)
  {
    for(int j = 0; j < 8; j++)
    {
      int x = (width-225)+(j%2*150);
      int y = 180+(150*(j/2));
      if(towers.get(i).xPos == x && towers.get(i).yPos == y && !towers.get(i).bought)
      {
        stocked[j] = true;
        return true;
      }
    }
  }
  return false;
}
