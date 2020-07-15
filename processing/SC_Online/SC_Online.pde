Map m;
Player p;
Enemy e;
int x=0;
void setup(){
  // fullScreen();
  size(300,300);
  m=new Map(4,width,height);
  p=new Player();
  e=new Enemy(4);
  m.setup_map();
  frameRate(500);
}
void draw(){
  background(255);
  noCursor();
  m.kari_map();
  m.draw_map(x);
  e.draw_enemy();
  key_check();
  p.reticle(0);
  p.draw_hed();
  m.hit_check();
}

void key_check(){
  if(keyPressed==true){
    int a=5;
    if(key==' '){
      a=10;
    }
    if(key=='a'){
      x+=a;
      println(a);
    }else if(key=='d'){
      x-=a;
      println(a);
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
    imageMode(CENTER);
    image(map_buffer,x/map_kyori,-50,map_width/map_kyori,map_height/map_kyori);
    image(map_buffer,x,0);
  }
  void kari_map(){
    translate(map_width/2,map_height/2);
    rectMode(CENTER);
    map_buffer.beginDraw();
    map_buffer.background(0,0,0,0);
    map_buffer.translate(map_width/2,map_height/2);
    map_buffer.rectMode(CENTER);
    map_buffer.fill(0);
    map_buffer.rect(0,0,100,200);
    map_buffer.endDraw();
  }
  void setup_map(){
    map_buffer=createGraphics(map_width,map_height);
  }
  void hit_check(){
    rectMode(CORNERS);
    // println(mouseX,mouseY);
    // rect((-50+x)/map_kyori,-100/map_kyori-50,(50+x)/map_kyori,100/map_kyori-50);
    if((mouseX>=100+x)&&(mouseY>=-250)&&(mouseX<=200+x)&&(mouseY<=200)){
      println("hit player side wall");
    }else if((mouseX>=(-50+x)/map_kyori+150)&&(mouseY>=(-100)/map_kyori-50+150)&&(mouseX<=(50+x)/map_kyori+150)&&(mouseY<=(100/map_kyori-50)+150)){
      println("hit enemy side wall");
    }
  }
}


class Player{
  Player(){
  }

  void reticle(int type){
    pushMatrix();
    fill(255,0,0,200);
    translate(-width/2,-height/2);
    // println(width,height);
    rectMode(CORNER);
    if (type==0){
      rect(mouseX-1,mouseY-5,2,4);
      rect(mouseX-1,mouseY+2,2,4);
      rect(mouseX-6,mouseY-1,4,2);
      rect(mouseX+2,mouseY-1,4,2);
    }else if(type==1){
      fill(255);
      stroke(0);
      rect(mouseX,mouseY,2,2);
    }
    popMatrix();
  }
  void draw_hed(){
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
  int pos_x,pos_y,kyori;
  boolean squat;
  Enemy(int _kyori){
    kyori=_kyori;
  }
  // void setup_enemy(){

  // }
  void draw_enemy(){
    rectMode(CENTER);
    rect((pos_x+x)/kyori,-50,100/kyori,100/kyori);
  }
  void move_enemy(int ps_x,int ps_y){
    pos_x=ps_x;
    pos_y=ps_y;
    draw_enemy();
  }
  void squat_enemy(){

  }
}

class Gun{
  Gun(){

  }
}

class Bullet{
  Bullet(){

  }
}
