ArrayList<Towers> towers = new ArrayList<Towers>();
ArrayList<TowerShots> tShots = new ArrayList<TowerShots>();
ArrayList<Enemies> enemies = new ArrayList<Enemies>();

int boxSize = 100;

//boolean mouseOnGrid();

void setup()
{
  size(1200,800);
  //fullScreen();
  //noStroke();
}
void draw()
{
  drawBackground();
  handleTowers();
  handleEnemies();
  handleTowerShot();
}
void keyPressed()
{
  if(key == 'e')
  {
    enemies.add(new Enemies(mouseX,mouseY,0));
  }
  if(key == 'E')//wave
  {
    for(int i = 0; i < 15; i++)
      enemies.add(new Enemies(width + random(50,750),random(0,height-boxSize),0));
  }
  if(key == 't' && !spaceOccupied())
  {
    towers.add(new Towers(mouseX,mouseY,1));
  }
}
void mousePressed()
{
  if((mouseButton == RIGHT) && !spaceOccupied())//spawn new tower
  {
    towers.add(new Towers(mouseX,mouseY,1));
  }
  for(Towers t: towers)
  {
    if(dist(mouseX,mouseY,t.xPos,t.yPos) < t.size/2 && (mouseButton == LEFT) )//&& mouseOnGrid())//grabbing towers
    {
      t.grabbed = true;
    }
  }
  
}
void mouseReleased()
{
  for(Towers t: towers)//dropping towers
  {
    t.grabbed = false;
  }
}
void drawBackground()
{
  background(0);
  for(int i = 0; i < width-(boxSize*3); i += boxSize) 
  {
    for(int j = 0; j < height-(boxSize*1); j += boxSize) 
    { 
      //fill((j+50)/5);
      rect(i, j, boxSize, boxSize);  
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
    
  }
  for(int i = 0; i < towers.size(); i++)
  {
    if(!towers.get(i).active)
    {
      towers.remove(i);
    }
  }
  
}

boolean spaceOccupied()
{
  for(int i = 0; i < towers.size(); i++)
  {
    if(dist(mouseX,mouseY,towers.get(i).xPos,towers.get(i).yPos) < (towers.get(i).size/2)+10)
    {
      println("there is already a tower there");
      return true;
    }
  }
  return false;
}

void handleEnemies()
{
  for(Enemies e: enemies)
  {
    e.drawEnemies();
    e.moveEnemies();
    e.hitTowers();
  }
  
  for(int i = 0; i < enemies.size(); i++)
  {
    if(!enemies.get(i).active)
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



boolean mouseOnGrid()
{
  if(mouseX < width-(boxSize*3) && mouseY < height-(boxSize*1))
  {
    return true;
  }
  return false;
}
