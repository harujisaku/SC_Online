Map m;
Player p;
Enemy e;
int x=0,y=0;
int bit;
int a;
int speed=5;
int jamp_var;
int y_prev,y_temp,damage;
boolean jamp_flg,right,left,fire_flg=false;
Gun[] guns;
Gun g;
void setup(){
  // fullScreen();
  g = new Gun(50,10);
  guns = new Gun[1];
  guns[0] = g;
  size(300,300);
  m=new Map(4,width,height);
  p=new Player(100);
  e=new Enemy(4,100);
  m.setup_map();
  frameRate(500);
}
void draw(){
  background(255);
  noCursor();
  m.kari_map();
  m.draw_map(x);
  e.move_enemy(-(x),-(y));
  e.draw_enemy();
  if(guns[0].fire()){
    // println("variables");
    e.damage(guns[0].damage);
  }
  // e.hit_check();
  key_check();
  p.reticle(0);
  p.draw_hed();
  m.hit_check();
  p.jamp();
  // println(e.hp);
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
  if (((bit&(1<<0))>0)&&(jamp_flg==false)){
    x-=speed;
  }
  if (((bit&(1<<1))>0)&&(jamp_flg==false)) x+=speed;
  if ((bit&(1<<6))>0){
    if(jamp_flg==false){
      jamp_flg=true;
      if ((bit&(1<<0))>0){
        right=true;
        left=false;
      }
      if (((bit&(1<<1))>0)){
        left=true;
        right=false;
      }
    }
  }else{
    if((jamp_var>25)&&(jamp_flg==true)){
      jamp_flg=false;
      jamp_var=0;
    }
    right=false;
    left=false;
  }
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

void mousePressed(){
  fire_flg=e.hit_check();
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
  int hp;
  Player(int _hp){
    hp=_hp;
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
    // fill(0,0,0,0);
    fill(0,0,0);
    stroke(0);
    rect(0,0,100,100);
    stroke(255);
    rect(0,0,98,98);
    stroke(0);
    rect(0,0,96,96);
    rectMode(CORNER);
  }
  void jamp(){
    if(jamp_flg==true){
      // if(y<50){
      //
      // }
      y+=100;
      if(right){
        x-=15;
      }else if(left){
        x+=15;
      }
      jamp_var++;
      if(jamp_var>20){
        y-=50;
      }
    }
  }


}

class Enemy{
  int pos_x,pos_y,kyori,hp;
  boolean squat,alive;
  Enemy(int _kyori,int _hp){
    kyori=_kyori;
    hp=_hp;
    squat=false;
    alive=false;
  }
  // void setup_enemy(){

  // }
  void draw_enemy(){
    if(hp>0){
      alive=true;
      rectMode(CENTER);
      rect((pos_x)/kyori,-50+y/kyori,100/kyori,100/kyori);
    }else{
      alive=false;
    }
  }
  void move_enemy(int ps_x,int ps_y){
    pos_x=ps_x;
    pos_y=ps_y;
    draw_enemy();
  }
  void squat_enemy(){

  }

  boolean hit_check(){
    // rectMode(CORNERS);
    // rect(pos_x/kyori-11.5,(-50+y/kyori)-11.5,pos_x/kyori+100/kyori-11.5,(-50+y/kyori)+100/kyori-11.5);
    if((mouseX>=pos_x/kyori+140)&&(mouseY>=(-50+y/kyori)+140)&&(mouseX<=pos_x/kyori+140+100/kyori)&&(mouseY<=(-50+y/kyori)+140+100/kyori)){
      return true;
    }else{
      return false;
    }
  }
  int damage(int _damage){
    hp=hp-_damage;
    if(hp>=0){
      alive=true;
    }
    println(hp);
    return hp;
  }
}

class Gun{
  int damage,reroad_time,time_count=0;
  Gun(int _damage,int _reroad_time){
    damage=_damage;
    reroad_time=_reroad_time;
  }
  boolean fire(){
    if(fire_flg){
      if(time_count==0){
        time_count++;
        return true;
      }
      time_count++;
      println(time_count,reroad_time);
      if(time_count>reroad_time){
        println("variables2");
        fire_flg=false;
        time_count=0;
      }
      return false;
    }else{
      return false;
    }
  }
}

class Bullet{
  Bullet(){

  }
}
