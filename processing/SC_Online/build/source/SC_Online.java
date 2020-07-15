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

map m;
int x=-100;
public void setup(){
  
  m=new map(5);
  m.setup_map();
}
public void draw(){
  background(255);
  m.kari_map();
  m.draw_map(x);
}

public void keyPressed(){
  if(key==CODED){
    if(keyCode==RIGHT){
      x+=10;
    }else if(keyCode==LEFT){
      x-=10;
    }
  }
}


class map{
  PGraphics map_buffer;
  int x,y;
  int map_kyori;
  int map_width=800,map_height=300;
  map(int kyori){
    map_kyori=kyori;
  }
  public void setup_map(){
    map_buffer=createGraphics(map_width,map_height);
  }
  public void kari_map(){
    map_buffer.beginDraw();
    map_buffer.rect(map_width/2-100,map_height-200,200,100);
    map_buffer.endDraw();
  }
  public void draw_map(int _x){
    x=_x;
    imageMode(CENTER);
    image(map_buffer,width/2+x/map_kyori,height/2,width/map_kyori,height/map_kyori);
    imageMode(CORNER);
    image(map_buffer,x,0);
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
