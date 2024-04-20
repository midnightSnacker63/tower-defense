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
  int cooldown = 600;//how fast they attack
  int normalCooldown = cooldown;
  int hitTimer;// for when they get hit by bombs
  int hitCooldown = 250;
  int shotTimer;//how fast they shoot if they do
  int shotCooldown;
  int slowedTimer;
  int red = 255;
  int green = 255;
  int blue = 255;
  
  boolean active;
  boolean shoots;
  boolean slowed;
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
    image(bossImage[type],xPos,yPos);
    
    push();//health bar
    rectMode(CORNER);
    noFill();
    rect(xPos-size/2-25, yPos+150, maxHealth*0.4, 20);
    fill(255, 10, 0);
    rect(xPos-size/2-25, yPos+150, health*0.4, 20);
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
    }
    if( abs(ySpd) < 0.15 && dist(xPos,yPos,xDest,yDest) < 25)//if close to destination and slow enough then it will just stop
    {
      ySpd = 0;
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
        maxHealth = 1000;
        speed = 1;
        damage = 10;
        cooldown = 5000;
        xDest = 780;
        yDest = 375;
        return;
    }
  }
  
  void takeDamage(float amount)//allows enemies to take damage
  {
    health -= amount;//remove health
    if(health <= 0)//kill enemy if health is 0
    {
      active = false;
      money += maxHealth/2;
      return;
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
