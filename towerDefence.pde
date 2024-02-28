ArrayList<Towers> towers = new ArrayList<Towers>();
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
  towers.add(new Towers(mouseX,mouseY));
}
void mousePressed()
{
  towers.add(new Towers(mouseX,mouseY));
  
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
