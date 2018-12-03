class refreshPattern{
  float b;
  float x, y;
  float hue;
  float hueOff;
  float hueStep;
  float xOff;
  float yOff;
  float xStep;
  float yStep;
  
  refreshPattern(){
    x = random(0, width); 
    y = random(0, height);
    xOff = random(50);
    yOff = random(150);
    xStep = random(0.1, 0.8);
    yStep = random(0.4,0.8);
  }
  
  void drawRefreshPattern(){
  for(int j = 0; j < 100; j ++ ){
    for(int i = 0; i < 100; i ++ ){
      float size;
      noStroke();
      fill(0, 100, 0, 10); // nebula 
      size = 6;
      float r = random( -width, width);
      float t = random(0, 2*3.141592);
      ellipse(x + r * cos(t), y + r * sin(t), size, size);
    }
      updatePosition();
  }
}
  
  void updatePosition(){
    if(random(200) < 1){
      float xMove = random(-0.5, 0.5);
      float yMove = random(-0.5, 0.5);
      x += xMove;
      y += yMove;
    }else{
      float xMove = random(-3, 3);
      float yMove = random(-3, 3);
      x += xMove;
      y += yMove;
    }

    xOff += xStep;
    yOff += yStep;
    if (x > width) x = 0;
    if (y > height) y = 0;
    if (x < 0) x = width;
    if (y < 0) y = height;
  }
  
 
}