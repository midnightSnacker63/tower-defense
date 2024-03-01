class TowerShots
{
  float xPos,yPos;
  float xSpd,ySpd;
  
  float size;
  
  float damage = 1;
  int cooldown = 1000;
  int type;
  
  boolean active;
  public TowerShots( float x, float y , int t)
  {
    xPos = x;
    yPos = y;
    type = t;
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
  
  void checkForHit()
  {
    for( int i = 0; i < enemies.size(); i++ )
      {
        if( dist( xPos,yPos, enemies.get(i).xPos,enemies.get(i).yPos ) < (size+enemies.get(i).size)/2  )
        {
          enemies.get(i).takeDamage(damage);
          active = false;
        }
      }
  }
}
