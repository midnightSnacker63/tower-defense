class Towers
{
  float xPos,yPos;
  float size;
  
  int type;
  int power;
  int maxHealth = 10;
  int health = maxHealth;
  
  boolean grabbed;
  boolean active;
  boolean attacking;
  
  public Towers(float x,float y, int t)
  {
    xPos = x;
    yPos = y;
    type = t;
    size = boxSize;
    active = true;
    xPos = round(mouseX / int(size)) * size + size/2;
    yPos = round(mouseY / int(size)) * size + size/2;
  }
  
  void drawTowers()
  {
    push();
    if(enemyAhead())
    {
      fill(255,0,0);
    }
    else
    {
      fill(255);
    }
    stroke(1);
    circle(xPos,yPos,size);
    pop();
    if(health <= 0)
    {
      active = false;
    }
    
  }
  
  void attack()
  {
    if(enemyAhead())
      tShots.add( new TowerShots(xPos,yPos));
  }
  
  void snapToGrid()
  {
    if(grabbed)
    {
      xPos = round(mouseX / int(size)) * size + size/2;
      yPos = round(mouseY / int(size)) * size + size/2;
    }
    
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
  
  boolean enemyAhead()
  {
    for( int i = 0; i < enemies.size(); i++ )
      if( enemies.get(i).yPos == yPos && enemies.get(i).xPos >= xPos )
        return true;
    return false;
  }
  
}
