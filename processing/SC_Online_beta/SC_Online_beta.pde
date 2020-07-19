class BattleObject{
  int hp,lastDamage;
  boolean isAlive=true,isAttacking=false,canAtack=true;
  BattleObject(int _hp){
    hp=_hp;
  }

  void update(){

  }

  void takeDamage(int _damage){
    lastDamage=_damage;
    hp=hp-_damage;
    if(hp<=0){
      isAlive=false;
    }
  }

  void atack(){
    if(canAtack||isAttacking){
      isAttacking= !isAttacking;
    }
  }

  void noAtack(){
    isAttacking= false;
  }

  void setAtack(boolean _canAtack){
    canAtack=_canAtack;
  }

  int getHp(){
    return hp
  }

}
