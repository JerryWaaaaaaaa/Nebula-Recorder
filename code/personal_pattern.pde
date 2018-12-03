class personalPattern{
  float ox, oy;
  float x, y;
  float hue;
  float hueOff;
  float hueStep;
  float xOff;
  float yOff;
  float xStep;
  float yStep;
  int age;
  int blackAge;
  
  personalPattern(float _x, float _y){
    ox = _x;
    oy = _y;
    x = _x; 
    y = _y;
    hue = round(random(pminHue,pmaxHue));
    hueOff = random(80);
    hueStep = random(0.5,1);
    xOff = random(50);
    yOff = random(150);
    xStep = random(0.1, 0.8);
    yStep = random(0.4,0.8);
    age = round(random(10,25));
    blackAge = age - 10;
  }
  
  void drawPersonalPattern(){
  if(age > 0){
    for(int j = 0; j < 100; j ++ ){
      for(int i = 0; i < 100; i ++ ){
        float size;
        noStroke();
        if(random(0, 10000) < 0.1){
          fill(hue, 0, 100, random(30,50)); // random white star
          size = random(1,4);
        }else{
          fill(hue, 100, 100, 4); // nebula 
          size = 2;
        }
        float r = random( -width/2, width/2);
        float t = random(0, 2*3.141592);
        ellipse(x + r * cos(t), y + r * sin(t), size, size);
      }
        updatePosition();
    }
      updateHue();
      age --;
  }else if(age <= 0 && blackAge > 0){
    x = ox;
    y = oy;
    for(int j = 0; j < 100; j ++ ){
      for(int i = 0; i < 100; i ++ ){
        float size;
        noStroke();
        fill(0, 100, 0, 6); // black 
        size = 2;
        float r = random( -width, width);
        float t = random(0, 2*3.141592);
        ellipse(x + r * cos(t), y + r * sin(t), size, size);
      }
      updateBlackPosition();
    }
    blackAge --;
  }
}
  
  void updatePosition(){
    float xMove = random(-2.5, 2.5);
    float yMove = random(-2.5, 2.5);
    x += xMove;
    y += yMove;
    xOff += xStep;
    yOff += yStep;
    if (x > width) x = 0;
    if (y > height) y = 0;
    if (x < 0) x = width;
    if (y < 0) y = height;
  }
  
  void updateBlackPosition(){
    float xMove = random(-3.5, 3.5);
    float yMove = random(-3.5, 3.5);
    x += xMove;
    y += yMove;
    xOff += xStep;
    yOff += yStep;
    if (x > width) x = 0;
    if (y > height) y = 0;
    if (x < 0) x = width;
    if (y < 0) y = height;
  }
  
  void updateHue(){
    float hueMove = noise(hueOff) * 1;
    hue += random(-hueMove, hueMove);
    hueOff += hueStep;
    if (hue > pmaxHue) hue = pminHue;
    if (hue < pminHue) hue = pmaxHue;
  }
  
}