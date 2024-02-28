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
    stroke(1);
    circle(xPos,yPos,size);
    pop();
    if(health <= 0)
    {
      active = false;
    }
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
}
