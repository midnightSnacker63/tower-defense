class TowerShots
{
  float xPos,yPos;
  float xSpd,ySpd;
  
  float size;
  
  int damage;
  
  boolean active;
  public TowerShots( float x, float y )
  {
    xPos = x;
    yPos = y;
    size = 50;
    active = true;
  }
  
  void drawShot()
  {
    if(active)
    {
      push();
      circle(xPos,yPos,50);
      pop();
    }
  }
  
  void moveShot()
  {
    if(active)
    {
      xSpd += 0.5;
    }
    
    xSpd *= 0.95;
    ySpd *= 0.95;
    
    xPos += xSpd;
    yPos += ySpd;
  }
}
