Map m;
Player p;
Enemy e;
int x=0,y=0;
int bit;
int a;
int speed=5;
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
  speed=5;
  y=0;
  if ((bit&(1<<5))>0){
    speed=10;
  }
  if ((bit&(1<<4))>0){
    y-=50;
    speed-=3;
    }
  if ((bit&(1<<0))>0){
    x-=speed;
  }
  if ((bit&(1<<1))>0) x+=speed;
  if ((bit&(1<<6))>0) y+=50;
  // if ((bit&(1<<2))>0) b+=1;
  // if ((bit&(1<<3))>0) b-=1;
}

void keyPressed(){
  if (keyCode == 68) bit |= (1<<0); //00000001
  if (keyCode == 65)  bit |= (1<<1); //00000010
  if (keyCode == 87)    bit |= (1<<2); //00000100
  if (keyCode == 83)  bit |= (1<<3); //00001000
  if (keyCode == SHIFT)  bit |= (1<<4); //00001000
  if (keyCode == CONTROL)  bit |= (1<<5); //00001000
  if (keyCode == 32)  bit |= (1<<6); //00001000
  if (keyCode == 81)  bit |= (1<<7); //00001000
  if (keyCode == 69)  bit |= (1<<8); //00001000
}

void keyReleased(){
  if (keyCode == 68) bit &= ~(1<<0);
  if (keyCode == 65)  bit &= ~(1<<1);
  if (keyCode == 87)    bit &= ~(1<<2);
  if (keyCode == 83)  bit &= ~(1<<3);
  if (keyCode == SHIFT)  bit &= ~(1<<4);
  if (keyCode == CONTROL)  bit &= ~(1<<5);
  if (keyCode == 32)  bit &= ~(1<<6);
  if (keyCode == 81)  bit &= ~(1<<7);
  if (keyCode == 69)  bit &= ~(1<<8);
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
    image(map_buffer,x/map_kyori,-50+y/map_kyori,map_width/map_kyori,map_height/map_kyori);
    image(map_buffer,x,y);
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
    // rectMode(CORNERS);
    // println(mouseX,mouseY);
    // rect(100+x,-250,200+x,200);
    if((mouseX>=100+x)&&(mouseY>=50+y)&&(mouseX<=200+x)&&(mouseY<=250)){
      // println("hit player side wall",a);
    }else if((mouseX>=(-50+x)/map_kyori+150)&&(mouseY>=(-100+y)/map_kyori-50+150)&&(mouseX<=(50+x)/map_kyori+150)&&(mouseY<=((100+y)/map_kyori-50)+150)){
      // println("hit enemy side wall");
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
  void jamp(){

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
    rect((pos_x+x)/kyori,-50+y/kyori,100/kyori,100/kyori);
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
