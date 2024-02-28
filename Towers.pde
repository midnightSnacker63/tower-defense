class Towers
{
  float xPos,yPos;
  float size;
  public Towers(float x,float y)
  {
    xPos = x;
    yPos = y;
    size = boxSize;
    xPos = round(mouseX / int(size)) * size + size/2 ;
    yPos = round(mouseY / int(size)) * size + size/2;
  }
  
  void drawTowers()
  {
    push();
    stroke(1);
    circle(xPos,yPos,size);
    pop();
  }
  
  void snapToGrid()
  {
    //snip.towerX =  round(mouseX / snip.size) * snip.size + snip.size/2;
  //snip.towerY =  round(mouseY / snip.size) * snip.size + snip.size/2;
    
  }
  
 
}
