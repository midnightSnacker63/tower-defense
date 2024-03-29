class Enemies
{
  float xPos, yPos;
  float xSpd, ySpd;
  float size;
  float maxHealth = 10;
  float health = maxHealth;
  float speed = 1;
  
  int type;
  int damage = 1;
  int timer;
  int cooldown = 600;
  
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
    push();
    fill(200,10,10);
    image(enemyImage[type],xPos,yPos);
    fill(0);
    text(int(health),xPos,yPos);
    pop();
    if(health <= 0)//kill it if health is 0
    {
      active = false;
    }
  }
  
  void moveEnemies()//movement
  {
    if(!frontBlocked())//only move if their front isnt blocked
    {
      xSpd -= 0.02 * speed;
    }
    else
    {
      xSpd = 0.0;
    }
    if(xPos < -size)//makes you take damage if it goes offscreen and also kills it
    {
      if(life > 0)
        life -= health;
      if(life <= 0)
      {
        life = 0;
      }
      
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
        maxHealth = 10;
        return;
      case 1:
        maxHealth = 15;
        speed = 1.25;
        return;
      case 2://brute
        maxHealth = 50;
        speed = 0.45;
        cooldown = 3500;
        damage = 10;
        return;
      case 3://fast with little health
        maxHealth = 5;
        speed = 3;
        cooldown = 500;
        return;
        
    }
  }
  
  void takeDamage(float amount, float knockback)//allows enemies to take damage
  {
    health -= amount;
    xSpd += knockback;
    if(frontBlocked())
    {
      xSpd += knockback;
    }
    if(health <= 0)
    {
      active = false;
      money += maxHealth/2;
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
