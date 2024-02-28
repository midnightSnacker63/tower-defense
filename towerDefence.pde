ArrayList<Towers> towers = new ArrayList<Towers>();
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
  background(0);
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
  }
}
void handleEnemies()
{
  for(Enemies e: enemies)
  {
    e.drawEnemies();
    e.moveEnemies();
    
  }
  //for( Enemies e:enemies )
  //{
  //  for ( Towers t: towers )
  //  {
  //    if( dist(e.xPos,e.yPos,t.xPos,t.yPos) < (e.size+t.size)/2)
  //    {
  //      e.frontBlocked = true;
  //    }
  //    else
  //    {
  //      e.frontBlocked = false;
  //    }
  //  }
  //}
}
