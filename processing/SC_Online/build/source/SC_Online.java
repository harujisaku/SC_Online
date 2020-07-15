import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class SC_Online extends PApplet {

Map m;
Player p;
int x=0;
public void setup(){
  // fullScreen();
  
  m=new Map(4,width,height);
  p=new Player();
  m.setup_map();
  frameRate(60);
}
public void draw(){
  background(255);
  noCursor();
  m.kari_map();
  m.draw_map(x);
  key_check();
  p.reticle();
  p.draw_hed();
}

public void key_check(){
  if(keyPressed==true){
    if(key==CODED){
      if(keyCode==RIGHT){
        x-=10;
      }else if(keyCode==LEFT){
        x+=10;
      }
    }else if(key=='a'){
      x+=5;
    }else if(key=='d'){
      x-=5;
    }
  }
}

class Map{
  PGraphics map_buffer;
  int map_kyori,map_width,map_height;
  Map(int _kyori,int _width,int _height){
    map_kyori=_kyori;
    map_width=_width;
    map_height=_height;
  }
  public void draw_map(int a){
    // translate(map_width/2,map_height/2);

    // rectMode(CENTER);
  }
  public void kari_map(){
    translate(map_width/2,map_height/2);
    rectMode(CENTER);
    rect(0,-50,100,100);
  }
  public void setup_map(){
    map_buffer=createGraphics(map_width,map_height);
  }
}


class Player{
  Player(){
  }

  public void reticle(){
    pushMatrix();
    fill(255,0,0,200);
    translate(-width/2,-height/2);
    // println(width,height);
    rectMode(CORNER);
    rect(mouseX-1,mouseY-5,2,4);
    rect(mouseX-1,mouseY+2,2,4);
    rect(mouseX-6,mouseY-1,4,2);
    rect(mouseX+2,mouseY-1,4,2);
    popMatrix();
  }
  public void draw_hed(){
    rectMode(CENTER);
    fill(0,0,0,0);
    stroke(0);
    rect(0,0,100,100);
    stroke(255);
    rect(0,0,98,98);
    stroke(0);
    rect(0,0,96,96);
    rectMode(CORNER);
  }
}

class Enemy{
  Enemy(){

  }
}
  public void settings() {  size(300,300); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "SC_Online" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
