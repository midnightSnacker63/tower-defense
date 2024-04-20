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
  public Boss(int x, int y, int t)
  {
    setTraits();
  }
  
  void drawBoss()
  {
    image(bossImage[type])
  }
  
  void moveBoss()
  {
  
  }
  
  void setTraits()
  {
    
  }
}
