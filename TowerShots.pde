class TowerShots
{
  float xPos,yPos;
  float xSpd,ySpd;
  
  float speed = 1;//speed multiplier
  
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
    setTraits();
  }
  
  void drawShot()//draw shots
  {
    if(active)
    {
      push();
      circle(xPos,yPos,50);
      pop();
    }
    if(xPos > width-250)
    {
      active = false;
    }
    
  }
  
  void moveShot()//movement
  {
    if(active)
    {
      xSpd += 0.5 * speed;
    }
    
    xSpd *= 0.95;
    ySpd *= 0.95;
    
    xPos += xSpd;
    yPos += ySpd;
  }
  void setTraits()//set traits for towers
  {
    switch(type)
    {
      case 0:
        damage = 1;
        return;
      case 1:
        damage = 1;
        speed = 1.25;
        return;
      case 2:
        return;
      case 3:
        damage = 10;
        speed = 0.7;
        return;
      case 4:
        damage = .5;
        speed = 0.7;
        return;
      case 5:
        damage = .10;
        speed = 1.5;
        return;
    }
  }
  void checkForHit()//allows it to hit enemies
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
