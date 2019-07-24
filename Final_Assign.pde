//import sounds
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

//images
PImage restaurant;
PImage bacon;
PImage base;
PImage cheese;
PImage tomato;
PImage fish;

//sound
Minim minim;
AudioPlayer soundPoint;
AudioPlayer soundMiss;
AudioPlayer soundWin;
AudioPlayer soundLose;

//variables
int score = 0;
int misses = 0;

float xBase = 175;
float yBase = 430;

int xBacon = 0;
float yBacon = 100;
int xCheese = 50;
float yCheese = -1000;
int xTomato = 100;
float yTomato = -1500;
int xFish = 5;
float yFish = -70;

int baconAmount = 0;
int tomatoAmount = 0;
int cheeseAmount = 0;
int fishAmount = 0;

float baconSpeed = 1;
float cheeseSpeed = 1;
float tomatoSpeed = 1;
float fishSpeed = 1;

float time = 0;

void setup(){
  
  //sound
  minim = new Minim(this);
  soundPoint = minim.loadFile("point.wav");
  soundMiss = minim.loadFile("miss.wav");
  soundWin = minim.loadFile("good.wav");
  soundLose = minim.loadFile("lose.wav");
  
  size(500, 500);
  //load images
  frameRate(100);
  
  //load images
  bacon = loadImage("bacon.png");
  bacon.resize(150, 70);
  cheese = loadImage("cheese.png");
  cheese.resize(150, 70);
  tomato = loadImage("tomato.png");
  tomato.resize(150, 70);
  fish = loadImage("fish.png");
  fish.resize(150, 70);
  
  base = loadImage("base.png");
  base.resize(150, 70);
  restaurant = loadImage("rest.jpg");
  
  restaurant.resize(500, 500);
  //place restaurant as background image
}

void draw(){
  //restaurant background
  background(180);
  tint(255, 100);
  image(restaurant, 0, 0);
  
  //Background Details
  tint(255, 255);
  textSize(50);
  text("Score"+score, 250, 250);
  text("Misses"+ misses, 200, 200);
  textSize(30);
  fill(130, 57, 53);
  text("Bacon +1", 0, 30);
  fill(181, 122, 21);
  text("Cheese +3", 0, 60);
  fill(186, 59, 24);
  text("Tomato +10", 0, 90);
  fill(18, 128, 168);
  text("Fish -50", 0, 120);
  
  //Place images on screen
  image(base, xBase, yBase);
  image(tomato, xTomato, yTomato);
  if (tomatoAmount >= 1){
    image(tomato, xBase, yBase-40);
  }
  image(bacon, xBacon, yBacon);
  if (baconAmount >= 1){
    image(bacon, xBase, yBase-50);
  }
  image(cheese, xCheese, yCheese);
  if (cheeseAmount >= 1){
    image(cheese, xBase, yBase-70);
  }
  image(fish, xFish, yFish);
  if (fishAmount >= 1){
    image(fish, xBase, yBase-100);
  }
  
  
  //move objects down the screen
  yBacon+= baconSpeed;
  yCheese+= cheeseSpeed;
  yTomato+= tomatoSpeed;
  //move bacon back to top of screen
  if(yBacon > height ){
    yBacon = -100;
    xBacon = (int)random(0, width - bacon.width);
  }
  
  if(yCheese > height){
    yCheese = -1000;
    xCheese = (int)random(0, width - cheese.width);
  }
  
  if(yTomato > height){
    yTomato = -1500;
    xTomato = (int)random(0, width - tomato.width);
  }
  
  if(yFish > height){
    yFish = -70;
    xFish = (int)random(0, width - tomato.width);
  }
  if(score >= 20){
    yFish += fishSpeed;
  }
  
//if the object hits the bottom, or hits the burger go back to the top and give a point or miss
  if (yBacon + bacon.height >= yBase && xBacon + bacon.width >= xBase && xBacon <= xBase + base.width){
    yBacon = -100;
    xBacon = (int)random(0, 350);
    score ++;
    baconAmount ++;
    baconSpeed = random(1, 5);
    soundPoint.play();
    soundPoint.rewind();
  }
  else if(yBacon + bacon.height == height){
    misses++;
    yBacon = -100;
    xBacon = (int)random(0, 350);
    fishSpeed += 0.01;
    soundMiss.play();
    soundMiss.rewind();
  }
  
  if (yCheese + cheese.height >= yBase && xCheese + cheese.width >= xBase && xCheese <= xBase + base.width){
    yCheese = -1000;
    xCheese = (int)random(0, 350);
    score+= 3;
    cheeseAmount++;
    cheeseSpeed += 0.02;
    soundPoint.play();
    soundPoint.rewind();

  }
  else if(yCheese + cheese.height == height){
    misses+=3;
    yCheese = -1000;
    xCheese = (int)random(0, 350);
    fishSpeed += 0.01;
    soundMiss.play();
    soundMiss.rewind();
  }
  
  if (yTomato + cheese.height >= yBase && xTomato + tomato.width >= xBase && xTomato <= xBase + base.width){
    yTomato = -1500;
    xTomato = (int)random(0, 350);
    score+=10;
    tomatoAmount ++;
    tomatoSpeed += 0.03;
    soundPoint.play();
    soundPoint.rewind();
  }
  else if(yTomato + tomato.height == height){
    misses+=10;
    yTomato = -1500;
    xTomato = (int)random(0, 350);
    fishSpeed += 0.01;
    soundMiss.play();
    soundMiss.rewind();
  }

  if (yFish + fish.height >= yBase && xFish + fish.width >= xBase && xFish <= xBase + base.width){
    yFish = -70;
    xFish = (int)random(0, width-fish.width);
    misses += 50;
    fishAmount++;
    fishSpeed += 0.01;
    soundMiss.play();
    soundMiss.rewind();
  }
  else if (yFish + fish.height == height){
    yFish = -70;
    xFish = (int)random(0, 350);
    fishSpeed -= 0.01;
  }

  if(keyPressed){
    if(keyCode == LEFT){
      if(xBase > 0){
      xBase--;
      }
    }
    else if (keyCode == RIGHT){
      if(xBase + base.width < width){
      xBase++;
      }  
    }
  }
  //results win
 if (score >= 100 ){
   baconSpeed = 0;
   cheeseSpeed = 0;
   tomatoSpeed = 0;
   fishSpeed = 0;
   background(180);
   tint(255, 100);
   image(restaurant, 0, 0);
   text("You Won!! ", 100, 200);
   text("Time: " + time, 100, 250);
   text(score, 100, 300);
   soundWin.play();
 }
 
 //results miss
 else if (misses >= 100 ){
   baconSpeed = 0;
   cheeseSpeed = 0;
   tomatoSpeed = 0;
   fishSpeed = 0;
   background(180);
   tint(255, 100);
   image(restaurant, 0, 0);
   text("You Lost! ", 100, 200);
   text("Time: " + time, 100, 250);
   text(score, 100, 300);
   soundLose.play();
 }
 //time played
  else{
    time += 0.01;
 }
//restart
 if(mousePressed){
   if(mouseButton == RIGHT){
     score = 0;
     misses = 0;
     baconSpeed = 1;
     cheeseSpeed = 1;
     tomatoSpeed = 1;
     fishSpeed = 1;
     fishAmount = 0;
     tomatoAmount = 0;
     cheeseAmount = 0;
     baconAmount = 0;
     yBacon = -100;
     yTomato = -1500;
     yFish = -70;
     yCheese = -1000;
   }
 }
}

void stop(){
  soundPoint.close();
  soundMiss.close();
  soundWin.close();
}
