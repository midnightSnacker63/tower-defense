class Towers
{
  float xPos,yPos;
  float xSpd,ySpd;
  float size;
  
  int type;
  int power;
  int maxHealth = 10;
  int health = maxHealth;
  int timer;
  int cooldown = 1000;
  int price;
  int produceTimer;
  int produceCooldown = 2500;
  
  boolean grabbed;
  boolean active;
  boolean attacking;
  boolean canAttack = true;
  boolean bought = false;
  boolean producer;

  
  public Towers(float x,float y, int t)
  {
    xPos = x;
    yPos = y;
    type = t;
    size = boxSize;
    active = true;
    //xPos = round(mouseX / int(size)) * size + size/2;
    //yPos = round(mouseY / int(size)) * size + size/2;
    setTraits();
    health = maxHealth;
  }
  
  void drawTowers()
  {
    push();
    if(attacking)
    {
      fill(255,0,0);
    }
    else
    {
      fill(255);
    }
    stroke(1);
    image(towerImage[type],xPos,yPos);
    fill(0);
    text(health,xPos,yPos);
    pop();
    if(health <= 0)//kill it if health is 0
    {
      active = false;
    }
    
  }
  
  void moveTowers()
  {
    if(onGrid() && !grabbed)
    {
      xPos = round(int(xPos) / int(size)) * size + size/2;
      yPos = round(int(yPos) / int(size)) * size + size/2;
    }
    
    if(onGrid() && !grabbed && !bought)//removes tower if you cant afford it
    {
      println("get yo money up");
      active = false;
    }
    xSpd *= 0.97;
    ySpd *= 0.97;
    
    xPos += xSpd;
    yPos += ySpd;
  }
  
  
  void attack()//method for attacking
  {
    if(enemyAhead() && canAttack && bought && millis() > timer)
    {
      timer = millis() + cooldown;
      attacking = true;
      tShots.add( new TowerShots(xPos,random(yPos-15,yPos+15),type));
    }
    else 
      attacking = false;
  }
  
  void snapToGrid()//snaps towers to the grid when grabbed
  {
    if( grabbed  && !spaceOccupied() )
    {
      xPos = round(mouseX / int(size)) * size + size/2;
      yPos = round(mouseY / int(size)) * size + size/2;
      
    }
    
  }
  
  void returnToBoard()//if you try to drag it off the board it will not let you
  {
    if(!onGrid() && bought)
    {
      xPos -= 50;
    }
    if(yPos > height-(boxSize)-size/2)
    {
      yPos -= 50;
    }
    if(xPos < 0)
    {
      xPos += 50;
    }
    if(yPos < 0)
    {
      yPos += 50;
    }
  }
  
  void setTraits()//set traits for towers
  {
    switch(type)
    {
      case 0://basic little thing
        price = 10;
        maxHealth = 10;
        cooldown = 750;
        return;
      case 1://basic normal thing
        price = 25;
        maxHealth = 25;
        cooldown = 500;
        return;
      case 2://wall (does nothing but has a bunch of health)
        canAttack = false;
        price = 50;
        maxHealth = 100;
        return;
      case 3://cannon (slow with high damage)
        cooldown = 3000;
        maxHealth = 50;
        price = 100;
        return;
      case 4://fast (fast with low damage)
        cooldown = 250;
        maxHealth = 15;
        price = 50;
        return;
      case 5://producer (makes money)
        cooldown = 3000;
        maxHealth = 10;
        price = 50;
        canAttack = false;
        return;
        
    }
  }
  
  void takeDamage(float amount)//allows for towers to take damage
  {
    health -= amount;
    
    if(health <= 0)
    {
      active = false;
    }
  }
  
  boolean enemyAhead()//returns true if an enemy is up ahead and on the board
  {
    for( int i = 0; i < enemies.size(); i++ )
      if( enemies.get(i).yPos == yPos && enemies.get(i).xPos >= xPos && enemies.get(i).onGrid() )
        return true;
    return false;
  }
  
  
  boolean onGrid()//tells you when tower is on the grid
  {
    if(xPos < width-(boxSize*3) && yPos < height-(boxSize*1))
    {
      return true;
    }
    return false;
  }
}
