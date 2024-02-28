class Enemies
{
  float xPos, yPos;
  float xSpd, ySpd;
  float size;
  
  int type;
  
  boolean frontBlocked;
  boolean active;
  
  
  public Enemies(float x, float y, int t)
  {
    xPos = x;
    yPos = y;
    type = t;
    size = boxSize;
    active = true;
    yPos = round(mouseY / int(size)) * size + size/2;
  }
  
  void drawEnemies()
  {
    circle(xPos,yPos,size);
  }
  
  void moveEnemies()
  {
    if(!frontBlocked)
    {
      xSpd -= 0.12;
    }
    
    xSpd *= 0.97;
    
    xPos += xSpd;
    yPos += ySpd;
  }
}
