class UI
{
  String towerDescriptions[] = {
  "Small Fry, basic low damage\n$10 ",
  "CatFish, moderate stats\n$25 ",
  "Coral,doesn't attack but has\nhigh health\n$50",
  "CannonFish, high damage with\nexplosion but slow\n$250",
  "ArcherFish,fast speed but low \ndamage\n$50",
  "SunFish, produces money\n$50",
  "HeartFish, doesn't attack but \nhas moderate health and \nregenerates health\n$75",
  "pushes back enemies\n$50 ",
  "Mines, they explode if touched\n$50 ",
  "Double SunFish, they make\nmore money \n$125",
  "IceFish, slows enemies\n$75 ",
  " ",
  " ",
  " ",
  " ",
  " ",
  };
  
  PImage sellIcon;
  public UI()
  {
    sellIcon = loadImage("cashIcon.png");
    sellIcon.resize(75,0);
  }
  
  void drawBackground()
  {
    background(0);
    for(int i = 0; i < width-(boxSize*3); i += boxSize) 
    {
      for(int j = 0; j < height-(boxSize*1); j += boxSize) 
      { 
        //fill((j+50)/5);
        push();
        imageMode(CORNER);
        image(floorTile,i,j);
        //rect(i, j, boxSize, boxSize);  
        pop();
      }
    }
  }
  
  void drawInfo()
  {
    push();
    fill(0);
    textSize(25);
    text(life,(width-boxSize*3)+30,40);
    text("$"+money,(width-boxSize*3)+30,80);
    text("next wave size: "+ wave, 25, height - 70 );
    text("current difficulty: "+ difficulty, 25, height - 45 );
    rect(25,height - 30,waveTimer/(wave*100),20);//wave timer bar back
    fill(255,0,0);
    if(life > 0)
      rect(25,height - 30,(waveTimer - millis())/100,20);//wave timer bar
    pop();
    if(selling)
    {
      push();
      textAlign(CENTER);
      textSize(35);
      fill(0);
      text("SELLING!!!",width/2,height-55);
      pop();
    }
  }
  
  void drawInterface()
  {
    push();
    fill(#CE8A0A);
    rect(width-boxSize*3,0,width-boxSize*3,height);
    rect(0,height-boxSize,width-boxSize*3,height-boxSize);
    pop();
    for(int i = 0; i < 8; i++)
    {
      int x = (width-225)+(i%2*150);
      int y = 180+(150*(i/2));
      push();
      rectMode(CENTER);
      fill(#835B10);
      rect(x,y,120,120,25);
      image(towerImage[i+shopScroll],x,y);//the tower images in shop
      fill(0);
      text(shopTimer[i+shopScroll],x,y+50);
      pop();
      if(dist(mouseX,mouseY,x,y) < boxSize/2)//displays tower descriptions when hovering over in shop
      {
        push();
        textSize(20);
        fill(0);
        text(towerDescriptions[i+shopScroll],width-275,height-75);
        pop();
      }
    }
    push();
    textSize(20);
    fill(0);
    image(sellIcon,width-350,height-50);
    if(dist(mouseX,mouseY,width-350,height-50) < 45)
    {
      text("sell towers",width-275,height-75);
    }
    pop();
  }
  
  void drawStartScreen()
  {
    
  }
  
}
