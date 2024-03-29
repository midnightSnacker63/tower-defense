class UI
{
  public UI()
  {
  
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
    text(money,(width-boxSize*3)+30,80);
    text("current wave: "+ wave, 25, height - 70 );
    text("current difficulty: "+ difficulty, 25, height - 45 );
    rect(25,height - 30,waveTimer/(wave*100),20);//wave timer bar
    fill(255,0,0);
    rect(25,height - 30,(waveTimer - millis())/100,20);//wave timer bar
    pop();
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
      image(towerImage[i],x,y);
      pop();
    }
    
    
  }
}
