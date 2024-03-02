class Enemies
{
  float xPos, yPos;
  float xSpd, ySpd;
  float size;
  float maxHealth = 10;
  float health = maxHealth;
  
  int type;
  int damage = 1;
  int timer;
  int cooldown = 300;
  
  boolean active;
  
  public Enemies(float x, float y, int t)
  {
    xPos = x;
    yPos = y;
    type = t;
    size = boxSize;
    active = true;
    yPos = round(int(y) / int(size)) * size + size/2;//snap to the y axis
  }
  
  void drawEnemies()
  {
    push();
    fill(200,10,10);
    circle(xPos,yPos,size);
    fill(0);
    text(int(health),xPos,yPos);
    pop();
    if(health <= 0)
    {
      active = false;
    }
  }
  
  void moveEnemies()
  {
    if(!frontBlocked())//only move if their front isnt blocked
    {
      xSpd -= 0.15;
    }
    else
    {
      xSpd = 0;
      
    }
    if(xPos < -size)
    {
      
    }
    
    xSpd *= 0.97;
    ySpd *= 0.97;
    
    xPos += xSpd;
    yPos += ySpd;
  }
  
  void setTraits()
  {
    switch(type)
    {
      case 0:
        maxHealth = 10;
        return;
    }
  }
  
  void takeDamage(float amount)
  {
    health -= amount;
    
    if(health <= 0)
    {
      active = false;
    }
  }
  
  void hitTowers()
  {
    for( int i = 0; i < towers.size(); i++ )
      if( dist( xPos,yPos, towers.get(i).xPos,towers.get(i).yPos ) < ((size+towers.get(i).size)/2) && millis() > timer)
      {
        timer = millis() + cooldown;
        towers.get(i).takeDamage(damage);
      }
  }
  boolean frontBlocked()//returns true if something is in front of an enemy
  {
    for( int i = 0; i < towers.size(); i++ )
      if( dist( xPos,yPos, towers.get(i).xPos,towers.get(i).yPos ) < (size+towers.get(i).size)/2 )
      {
        return true;
      }
    return false;
  }
  
}
