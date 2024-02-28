ArrayList<Towers> towers = new ArrayList<Towers>();
ArrayList<Enemies> enemies = new ArrayList<Enemies>();
int boxSize = 75;

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
}
void keyPressed()
{
  if(key == 'e')
  {
    enemies.add(new Enemies(mouseX,mouseY,1));
  }
}
void mousePressed()
{
  if((mouseButton == RIGHT))//spawn new tower
    towers.add(new Towers(mouseX,mouseY,1));
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
    t.grabbed = false;
  }
}
void drawBackground()
{
  for(int i = 0; i < width-(boxSize*6); i += boxSize) 
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
  }
}
void handleEnemies()
{
  for(Enemies e: enemies)
  {
    e.drawEnemies();
    e.moveEnemies();
  }
}
