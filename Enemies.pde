class Enemies
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
  
  int type;
  
  int timer;
  int cooldown = 600;//how fast they attack
  int normalCooldown = cooldown;
  int hitTimer;// for when they get hit by bombs
  int hitCooldown = 100;
  int shotTimer;//how fast they shoot if they do
  int shotCooldown;
  int slowedTimer;
  int red = 255;
  int green = 255;
  int blue = 255;
  
  boolean active;
  boolean explosive;
  boolean shoots;
  boolean slowed;
  
  public Enemies(float x, float y, int t)
  {
    xPos = x;
    yPos = y;
    type = t;
    size = boxSize;
    active = true;
    yPos = round(int(y) / int(size)) * size + size/2;//snap to the y axis
    setTraits();
    normalSpeed = speed;
    normalCooldown = cooldown;
    health = maxHealth;
  }
  
  void drawEnemies()//drawing
  {
    if(!onGrid())
    {
      image(warning,width-350,yPos);
    }
    if(onGrid())
    {
      push();
      fill(200,10,10);
      tint(red,green,blue);
      image(enemyImage[type],xPos,yPos);
      fill(0);
      text(int(health),xPos,yPos);
      pop();
    }
    
    if(health <= 0)//kill it if health is 0
    {
      active = false;
    }
  }
  
  void moveEnemies()//movement
  {
    if(!frontBlocked())//only move if their front isnt blocked
    {
      xSpd -= (0.02 * speed);
    }
    else
    {
      xSpd += 0.005*power;
    }
    if(xPos < -size)//makes you take damage if it goes offscreen and also kills it
    {
      if(life > 0)
        life -= health;
      if(life <= 0)
        life = 0;
      
      active = false;
    }
    
    if(slowed && speed == normalSpeed)//for when they are slowed
    {
      red = 150;
      green = 150;
      speed = speed/2;
      cooldown *=2;
    }
    else if(!slowed)
    {
      speed = normalSpeed;
      red = 255;
      green = 255;
      cooldown = normalCooldown;
    }
    if(millis() > slowedTimer)
    {
      slowed = false;
    }
    
    xSpd *= 0.97;
    ySpd *= 0.97;
    
    xPos += xSpd;
    yPos += ySpd;
  }
  
  
  
  void setTraits()//set the traits for different enemy types
  {
    switch(type)
    {
      case 0:
        maxHealth = 10 * power;
        speed = 1 * power;
        damage = 1 * power;
        return;
      case 1:
        maxHealth = 15* power;
        speed = 1.25 * power;
        damage = 1 * power;
        return;
      case 2://fast with little health
        maxHealth = 5 * power;
        speed = 3 * power;
        cooldown = 500;
        knockedBack = 5;
        damage = .75 * power;
        return;
      case 3://brute
        maxHealth = 50 * power;
        speed = 0.5 * power;
        cooldown = 3500;
        damage = 10 * power;
        knockedBack = 0.25;
        return;
      case 4://low health but blow up
        maxHealth = 1 * power;
        speed = 1.5 * power;
        cooldown = 600;
        knockedBack = 3;
        damage = 1 * power;
        explosive = true;
        return;
      case 5://shoot at towers
        maxHealth = 20 * power;
        speed = .9 * power;
        cooldown = 1000;
        knockedBack = 1;
        damage = 1 * power;
        shoots = true;
        shotCooldown = 1500;
        return;
      case 6://tbd
        maxHealth = 1 * power;
        speed = 1 * power;
        cooldown = 600;
        knockedBack = 1;
        damage = 1 * power;
        return;
      case 7://tbd
        maxHealth = 1 * power;
        speed = 1 * power;
        cooldown = 600;
        knockedBack = 1;
        damage = 1 * power;
        return;
        
    }
  }
  
  void takeDamage(float amount, float knockback)//allows enemies to take damage
  {
    health -= amount;//remove health
    xSpd += knockback * knockedBack;//knockback from damage
    if(health <= 0)//kill enemy if health is 0
    {
      active = false;
      money += maxHealth/4;
      if(explosive)//explode if explosive
      {
        explosion.add(new Explosion(xPos,yPos,3));
      }
      return;
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
  void shoot()
  {
    if(shoots && onGrid() && millis() > shotTimer)
    {
      eShots.add( new EnemyShots(xPos,random(yPos-15,yPos+15),type));
      shotTimer = millis() + shotCooldown;
    }
  }
  boolean frontBlocked()//returns true if something is in front of an enemy
  {
    for( int i = 0; i < towers.size(); i++ )
      if( dist( xPos,yPos, towers.get(i).xPos,towers.get(i).yPos ) < (size+towers.get(i).size)/2 && towers.get(i).bought )
      {
        return true;
      }
    return false;
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
