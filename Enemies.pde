class Enemies
{
  float xPos, yPos;
  float xSpd, ySpd;
  float size;
  
  int type;
  
  //boolean frontBlocked;
  boolean active;
  
  public Enemies(float x, float y, int t)
  {
    xPos = x;
    yPos = y;
    type = t;
    size = boxSize;
    active = true;
    yPos = round(mouseY / int(size)) * size + size/2;//snap to the y axis
  }
  
  void drawEnemies()
  {
    push();
    fill(200,10,10);
    circle(xPos,yPos,size);
    pop();
  }
  
  void moveEnemies()
  {
    if(!frontBlocked())//only move if their fornt isnt blocked
    {
      xSpd -= 0.15;
    }
    else
    {
      xSpd = 0;
    }
    
    xSpd *= 0.97;
    ySpd *= 0.97;
    
    xPos += xSpd;
    yPos += ySpd;
  }
  
  boolean frontBlocked()//returns true if something is in front of an enemy
  {
    for( int i = 0; i < towers.size(); i++ )
      if( dist( xPos,yPos, towers.get(i).xPos,towers.get(i).yPos ) < (size+towers.get(i).size)/2 )//&& !frontBlocked)
        return true;
    return false;
  }
}
