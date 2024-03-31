class Enemies
{
  float xPos, yPos;
  float xSpd, ySpd;
  float size;
  float maxHealth = 10;
  float health = maxHealth;
  float speed = 1;
  float knockedBack = 1;//how much they get knocked back by shots
  float damage = 1;
  float armourHealth;
  float maxArmourHealth;
  
  int type;
  
  int timer;
  int cooldown = 600;
  int hitTimer;
  int hitCooldown = 100;
  
  boolean active;
  
  public Enemies(float x, float y, int t)
  {
    xPos = x;
    yPos = y;
    type = t;
    size = boxSize;
    active = true;
    yPos = round(int(y) / int(size)) * size + size/2;//snap to the y axis
    setTraits();
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
      case 2://brute
        maxHealth = 50 * power;
        speed = 0.45 * power;
        cooldown = 3500;
        damage = 10 * power;
        knockedBack = 0.3;
        return;
      case 3://fast with little health
        maxHealth = 5 * power;
        speed = 3 * power;
        cooldown = 500;
        knockedBack = 5;
        damage = .75 * power;
        return;
      case 4://tbd
        maxHealth = 10 * power;
        speed = 1 * power;
        cooldown = 600;
        knockedBack = 1;
        damage = 1 * power;
        return;
      case 5://tbd
        maxHealth = 10 * power;
        speed = 1 * power;
        cooldown = 600;
        knockedBack = 1;
        damage = 1 * power;
        return;
      case 6://tbd
        maxHealth = 10 * power;
        speed = 1 * power;
        cooldown = 600;
        knockedBack = 1;
        damage = 1 * power;
        return;
      case 7://tbd
        maxHealth = 10 * power;
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
      money += maxHealth/2;
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
