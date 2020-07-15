Map m;
Player p;
int x=0;
void setup(){
  println(displayWidth,displayHeight);
  // fullScreen();
  size(300,300);
  m=new Map(4,width,height);
  p=new Player();
  m.setup_map();
  frameRate(60);
}
void draw(){
  background(255);
  noCursor();
  m.kari_map();
  m.draw_map(x);
  key_check();
  p.reticle();
  p.draw_hed();
}

void key_check(){
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
  void draw_map(int a){

  }
  void kari_map(){
    map_buffer.translate(map_width,mao_height);
  }
  void setup_map(){
    translate(map_width/2,map_height);
    rectMode(CENTER);
    map_buffer=createGraphics(map_width,map_height);
  }
}


class Player{
  Player(){
  }

  void reticle(){
    fill(255,0,0);
    rect(mouseX-1,mouseY-5,2,4);
    rect(mouseX-1,mouseY+2,2,4);
    rect(mouseX-6,mouseY-1,4,2);
    rect(mouseX+2,mouseY-1,4,2);
  }
  void draw_hed(){
    rectMode(CENTER);
    fill(0,0,0,0);
    stroke(0);
    rect(width/2,height/2,100,100);
    stroke(255);
    rect(width/2,height/2,98,98);
    stroke(0);
    rect(width/2,height/2,96,96);
    rectMode(CORNER);
  }
}

class Enemy{
  Enemy(){

  }
}
