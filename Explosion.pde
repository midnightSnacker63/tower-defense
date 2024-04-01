class Explosion
{
  float xPos, yPos;
  float xSpd, ySpd;
  float size;//how big it is
  float damage;//how much damage it does
  float angle;
  float rotateSpeed = 0.25;//how fast it spins
  float maxSize;//maximum size it can reach
  float growthRate;//how fast it expands
  float speed; 
  
  int timer;//how long its been alive
  int lifeTime;//how long it will last
  int type;
  
  boolean active;
  boolean bad;//will damage enemies if false but damage towers if true
  
  
  public Explosion(float x, float y, int t)
  {
    xPos = x;
    yPos = y;
    type = t;
    
    active = true;
    
    setTraits();
    
    timer = millis() + lifeTime;
    
    
    //explosionPic.resize(int(size),int(size));
  }
  
  void explode()
  {
  
  }
  
  void drawExplosion()
  {
    push();
    translate(xPos,yPos);
    rotate(angle);
    if(size < maxSize)
      size+=growthRate;
    angle+=rotateSpeed;
    image(explosionPic,0,0,size,size);
    pop();
    if( millis() > timer )
    {
      active = false;
    }
  }
  
  void moveExplosion()
  {
    xSpd += 1 * speed;
    
    xSpd *= 0.97;
    ySpd *= 0.97;
    
    xPos += xSpd;
    yPos += ySpd;
  }
  
  void checkForHit()
  {
    for( int i = 0; i < enemies.size(); i++ )//enemies
    {
      if( dist( xPos,yPos, enemies.get(i).xPos,enemies.get(i).yPos ) < (size+enemies.get(i).size)/2 && active && millis() > enemies.get(i).hitTimer && !bad )
      {
        enemies.get(i).takeDamage(damage, .25);
        enemies.get(i).hitTimer = millis()+enemies.get(i).hitCooldown;
      }
    }
    for( int i = 0; i < towers.size(); i++ )//towers
    {
      if( dist( xPos,yPos, towers.get(i).xPos,towers.get(i).yPos ) < (size+towers.get(i).size)/2 && active && millis() > towers.get(i).hitTimer && bad && towers.get(i).bought)
      {
        towers.get(i).takeDamage(damage);
        towers.get(i).hitTimer = millis()+towers.get(i).hitCooldown;
      }
    }
  }
  
  void setTraits()
  {
    switch(type)
    {
      case 0:
        bad = false;
        damage = 5;
        //size = boxSize*2;
        maxSize = boxSize*2.5;
        lifeTime = 1000;
        growthRate = 5 * (boxSize/100);
        return;
      case 1://nuke enemies
        bad = false;
        damage = 5;
        //size = boxSize*2;
        maxSize = boxSize*8;
        lifeTime = 2500;
        growthRate = 15 * (boxSize/100);
        return;
      case 2://nuke towers
        bad = true;
        damage = 5;
        //size = boxSize*2;
        maxSize = boxSize*8;
        lifeTime = 2500;
        growthRate = 15 * (boxSize/100);
        return;
      case 3://enemy explosion
        bad = true;
        damage = 5;
        //size = boxSize*2;
        maxSize = boxSize*2.5;
        lifeTime = 1000;
        growthRate = 5 * (boxSize/100);
        return;
    }
  }
}
