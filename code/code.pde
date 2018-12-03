//This is the code for Intro to Generative System Final Project
//Modified from the code created by Ben Bergman
//Created by Jerry Wang

// -------- import library --------
import org.openkinect.processing.*;

// -------- Setting of Kinect --------
Kinect kinect;
PImage IrImage;
int[] depth;
int minthreshold = 10;
int maxthreshold = 900;
float sumX = 0;
float sumY = 0;
float totalPixels = 0;
float avgX;
float avgY;

int counter;

// -------- Setting of the background pattern --------
backgroundPattern[] backgroundP;
refreshPattern[] refreshP;
personalPattern[] personalP;
int minHue;
int maxHue;
int count;
boolean display; // if the refresh pattern should display
boolean checkUser; //check if user is in the range

// -------- Setting of the personal pattern --------
int pminHue;
int pmaxHue;

PImage img;

void setup() {
  noCursor();
  // -------- setting of the kinect --------
  kinect = new Kinect(this);
  kinect.initDepth();
  //kinect.enableIR(true);
  //kinect.enableColorDepth(true);
  IrImage = kinect.getDepthImage();
  depth = kinect.getRawDepth();
  img = createImage(IrImage.width, IrImage.height, RGB);
  
  // -------- setting of the canvas --------
  fullScreen();
  //size(1200,800);
  smooth();
  background(0);
  colorMode(HSB, 360, 100, 100);
  //frameRate(60);
  count = 0;
  counter = 0;
  display = true;
  checkUser = false;
  minHue = 140;
  maxHue = 320;
  pminHue = 10;
  pmaxHue = 50;

  // -------- Setting of the background pattern  --------
  backgroundP = new backgroundPattern[4];
  for (int i = 0; i < backgroundP.length; i ++) {
    backgroundP[i] = new backgroundPattern();
  }

  // -------- Setting of the refresh pattern  -------- 
  refreshP = new refreshPattern[5];
  for (int i = 0; i < refreshP.length; i ++) {
    refreshP[i] = new refreshPattern();
  }

  // -------- Setting of the personal pattern  --------
  personalP = new personalPattern[0];
  for (int i = 0; i < personalP.length; i ++) {
    personalP[i] = new personalPattern(avgX, avgY);
  }
}


void draw() {

  //background(0, 0, 40);
  //IrImage.loadPixels();
  img.loadPixels();
  for (int x = 0; x < IrImage.width; x ++ ) {
    for (int y = 0; y < IrImage.height; y ++ ) {
      int index = x + y * IrImage.width;
      if (depth[index] < maxthreshold && depth[index] > minthreshold) {
        sumX += x;
        sumY += y;
        totalPixels ++;
        img.pixels[index] = color(0, 0, 100);
      } else {
        img.pixels[index] = color(0, 0, 0);
      }
    }
  }
  IrImage.updatePixels();
  img.updatePixels();
  //image(img, 0, 0, width, height);
  
   // average tracking
   if(totalPixels != 0){
     avgX = sumX/totalPixels;
     avgY = sumY/totalPixels;
     avgX = map(avgX, 0, kinect.width, 0, width);
     avgY = map(avgY, kinect.height * 0.3, kinect.height * 0.7, -height/2, height);
     //fill(0, 0, 100, 50);
     //ellipse(avgX, avgY, 20,20);
   }

   checkUser();

   if(checkUser){  // when the user is in the ranges 
       // -------- adding of the personal pattern --------
       if(frameCount%5 == 0){
         personalPattern p = new personalPattern(avgX, avgY);
         personalP = (personalPattern[]) append(personalP, p);
       }

       // -------- drawing of the personal pattern --------
       for(int i = 0; i < personalP.length; i ++){
         personalP[i].drawPersonalPattern();
         if(personalP[i].blackAge <= 0){
           personalP = (personalPattern[]) shorten(personalP);
         }
       }
       println(personalP.length);
   }else{
       // -------- drawing of the background pattern --------
       if(counter != 0){ 
         for(int i = 0; i < backgroundP.length; i ++){
            backgroundP[i].drawBackgroundPattern();
         }
       }
   }

  // -------- refresh the background --------
   if(frameCount > 150){
      count ++;
      if(count < 300 && display == true){ 
        for(int i = 0; i < refreshP.length; i ++){
          //if(checkUser == false){
            refreshP[i].drawRefreshPattern();
          //}
        }
      }else if(count == 300){
        count = 0;
        display = !display;
      }
   }

   sumX = 0;
   sumY = 0;
   totalPixels = 0;
}

void checkUser() {
  if (totalPixels > 900) {
    if (counter != 1) {
      counter ++;
    } else if (counter == 1) {
      counter = 1;
    }
    checkUser = true;
  } else {
    checkUser = false;
  }
}