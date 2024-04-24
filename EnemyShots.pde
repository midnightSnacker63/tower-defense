class EnemyShots
{
  float xPos,yPos;
  float xSpd,ySpd;
  float speed = 1;//speed multiplier
  float size;
  float angle;
  float rotateSpeed;
  float knockback;
  float damage = 1;
  
  int cooldown = 1000;
  int type;
  int red = 255;
  int green = 255;
  int blue = 255;
  
  boolean active;
  boolean explosive;
  public EnemyShots( float x, float y , int t)
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
      translate(xPos,yPos);
      rotate(angle);
      angle+=rotateSpeed;
      tint(red,green,blue);
      image(enemyShotImage[type],0,0,size,size);
      //circle(xPos,yPos,50);
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
      xSpd -= 0.5 * speed;
    }
    
    xSpd *= 0.95;
    ySpd *= 0.95;
    
    xPos += xSpd;
    yPos += ySpd;
  }
  void setTraits()//set traits for enemy shots(if its empty then they dont shoot)
  {
    switch(type)
    {
      case 0: 
        return;
      case 1:
        return;
      case 2:
        return;
      case 3:
        return;
      case 4:
        return;
      case 5:
        damage = 1;
        speed = 1;
        rotateSpeed = 0.25;
        return;
      case 6:
        return;
      case 7:
        return;
      case 8://anchor
        damage = 25;
        speed = .2;
        size = boxSize*1.5;
        return;
    }
  }
  void checkForHit()//allows it to hit towers
  {
    for( int i = 0; i < towers.size(); i++ )
      {
        if( dist( xPos,yPos, towers.get(i).xPos,towers.get(i).yPos ) < (size+towers.get(i).size)/2 && active && towers.get(i).bought )
        {
          towers.get(i).takeDamage(damage);
          if(explosive)
          {
            explosion.add(new Explosion(xPos,yPos,0));
          }
          active = false;
        }
      }
  }
}
