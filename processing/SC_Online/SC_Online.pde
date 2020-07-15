map m;
int x=-100;
void setup(){
  size(300,300);
  m=new map(5);
  m.setup_map();
}
void draw(){
  background(255);
  m.kari_map();
  m.draw_map(x);
}

void keyPressed(){
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
  void setup_map(){
    map_buffer=createGraphics(map_width,map_height);
  }
  void kari_map(){
    map_buffer.beginDraw();
    map_buffer.rect(map_width/2-100,map_height-200,200,100);
    map_buffer.endDraw();
  }
  void draw_map(int _x){
    x=_x;
    imageMode(CENTER);
    image(map_buffer,width/2+x/map_kyori,height/2,width/map_kyori,height/map_kyori);
    imageMode(CORNER);
    image(map_buffer,x,0);
  }
}
