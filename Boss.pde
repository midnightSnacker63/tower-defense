class Boss
{
  float xPos, yPos;
  float xSpd, ySpd;
  float size;
  float maxHealth = 10;
  float health = maxHealth;
  float speed = 1;
  float normalSpeed = speed;
  float knockedBack = 1;//how much they get knocked back by shots
  float damage = 1;
  float armourHealth;
  float maxArmourHealth;
  float xDest,yDest;//the position which they will sit at
  
  int type;
  
  int timer;
  int cooldown = 100;//how fast they attack
  int normalCooldown = cooldown;
  
  int hitTimer;// for when they get hit by bombs
  int hitCooldown = 150;
  
  int shotTimer;//how fast they shoot if they do
  int shotCooldown;
  
  int slowedTimer;
  
  int summonTimer = millis() + 10000;
  int summonCooldown = 1000;
  
  int shockWaveTimer = millis() + 30000;
  int shockWaveCooldown = 1000;
    
  int red = 255;
  int green = 255;
  int blue = 255;
  
  boolean active;
  boolean shoots;
  boolean slowed;
  boolean rising;
  boolean inPos;
  boolean canBeHit;
  public Boss(int x, int y, int t)
  {
    xPos = x;
    yPos = y;
    type = t;
    setTraits();
    health = maxHealth;
    active = true;
  }
  
  void drawBoss()
  {
    tint(255,10,10);
    image(warning,xDest,yDest);
    tint(255,255,255);
    image(bossImage[type],xPos,yPos);
    push();//health bar
    rectMode(CORNER);
    noFill();
    rect(20, height-150, maxHealth*0.43, 20);
    fill(255, 10, 0);
    rect(20, height-150, health*0.43, 20);
    pop();
    
  }
  
  void moveBoss()
  {
    if( xPos < xDest )//go towards x destination
    {
      xSpd += 0.1 * speed;
    }
    if( xPos > xDest )//go towards x destination
    {
      xSpd -= 0.1 * speed;
    }
    if( yPos < yDest )//go towards y destination
    {
      ySpd += 0.1 * speed;
    }
    if( yPos > yDest )//go towards y destination
    {
      ySpd -= 0.1 * speed;
    }
    
    if(rising && inPos)
    {
      yDest -= 1 * speed;
      xSpd *= 0.1;
    }
    if(!rising && inPos)
    {
      yDest += 1 * speed;
      xSpd *= 0.1;
    }
    
    if(yPos < 0+size/2)
    {
      rising = false;
    }
    if(yPos > height-size)
    {
      rising = true;
    }
    
    if(dist(xPos,yPos,xDest,yDest) > 25)//friction based on how far they are from their destination
    {
      xSpd *= 0.95;
      ySpd *= 0.95;
    }
    else
    {
      xSpd *= 0.55;
      ySpd *= 0.55;
    }
    if( abs(xSpd) < 0.15 && dist(xPos,yPos,xDest,yDest) < 25)//if close to destination and slow enough then it will just stop
    {
      xSpd = 0;
      inPos = true;
      canBeHit = true;
    }
    if( abs(ySpd) < 0.15 && dist(xPos,yPos,xDest,yDest) < 25)//if close to destination and slow enough then it will just stop
    {
      ySpd = 0;
      inPos = true;
    }
    xPos += xSpd;
    yPos += ySpd;
  }
  
  void setTraits()
  {
    switch(type)
    {
      case 0:
        size = boxSize * 3;
        maxHealth = 2000;
        speed = 1;
        damage = 10;
        cooldown = 500;
        xDest = 780;
        yDest = 375;
        return;
    }
  }
  
  void takeDamage(float amount)//allows enemies to take damage
  {
    if(canBeHit)
      health -= amount;//remove health
    if(health <= 0)//kill enemy if health is 0
    {
      active = false;
      money += maxHealth/2;
      return;
    }
  }
  
  void summonEnemies()
  {
    if(millis() > summonTimer && inPos)
    {
      summonCooldown = int(random(7500,25000)/power);
      enemies.add(new Enemies(xPos + random(-150,-50),yPos + random(-150,150),int(random(0,difficulty))));
      summonTimer = millis() + summonCooldown;
      println("pop " + summonCooldown / 1000);
     
    }
  }
  
  void shockWave()
  {
    if(millis() > shockWaveTimer && inPos)
    {
      shockWaveCooldown = int(random(15000,35000)/power);
      eShots.add( new EnemyShots(xPos,random(yPos-150,yPos+150),8));
      shockWaveTimer = millis() + shockWaveCooldown;
      
    }
  }
  
  void hitTowers()//hitting towers
  {
    for( int i = 0; i < towers.size(); i++ )
      if( dist( xPos,yPos, towers.get(i).xPos,towers.get(i).yPos ) < ((size+towers.get(i).size)/2) && towers.get(i).bought && millis() > timer)
      {
        timer = millis() + cooldown;
        towers.get(i).takeDamage(damage);
      }
  }
  
  boolean onGrid()//tells you when enemy is on the grid
  {
    if(xPos < width-(boxSize*3)+size/2 && yPos < height-(boxSize*1))
    {
      return true;
    }
    return false;
  }
}
