class Explosion
{
  float xPos, yPos;
  float size;
  float damage;
  float angle;
  float rotateSpeed = 0.25;
  float maxSize;
  float growthRate;//how fast it expands
  
  int timer;//how long its been alive
  int lifeTime;//how long it will last
  int type;
  int hitTimer;
  int hitCooldown;
  
  boolean active;
  boolean bad;//will damage enemies if false but damage towers if true
  
  PImage explosionPic;
  public Explosion(float x, float y, int t)
  {
    xPos = x;
    yPos = y;
    type = t;
    
    active = true;
    
    setTraits();
    
    timer = millis() + lifeTime;
    
    explosionPic = loadImage("explosion.png");
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
    size+=growthRate;
    angle+=rotateSpeed;
    image(explosionPic,0,0,size,size);
    pop();
    if( millis() > timer || size > maxSize)
    {
      active = false;
    }
  }
  
  void moveExplosion()
  {
    
  }
  
  void checkForHit()
  {
    for( int i = 0; i < enemies.size(); i++ )
    {
      if( dist( xPos,yPos, enemies.get(i).xPos,enemies.get(i).yPos ) < (size+enemies.get(i).size)/2 && active && millis() > enemies.get(i).hitTimer )
      {
        enemies.get(i).takeDamage(damage, .1);
        enemies.get(i).hitTimer = millis()+enemies.get(i).hitCooldown;
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
        lifeTime = 2500;
        growthRate = 6 * (boxSize/100);
        return;
    }
  }
}
