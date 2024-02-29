ArrayList<Towers> towers = new ArrayList<Towers>();
ArrayList<TowerShots> tShots = new ArrayList<TowerShots>();
ArrayList<Enemies> enemies = new ArrayList<Enemies>();

int boxSize = 100;

//boolean mouseOnGrid();

void setup()
{
  size(1200,800);
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
}
void mousePressed()
{
  if((mouseButton == RIGHT))//spawn new tower
    towers.add(new Towers(mouseX,mouseY,0));
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
void handleEnemies()
{
  for(Enemies e: enemies)
  {
    e.drawEnemies();
    e.moveEnemies();
    
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
