class Towers
{
  float xPos,yPos;
  float size;
  
  int type;
  
  boolean grabbed;
  public Towers(float x,float y, int t)
  {
    xPos = x;
    yPos = y;
    type = t;
    size = boxSize;
    xPos = round(mouseX / int(size)) * size + size/2;
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
    if(grabbed)
    {
      xPos = round(mouseX / int(size)) * size + size/2;
      yPos = round(mouseY / int(size)) * size + size/2;
    }
  }
  
  void setTraits()
  {
    switch(type)
    {
      case 0:
        return;
    }
  }
  
 
}
