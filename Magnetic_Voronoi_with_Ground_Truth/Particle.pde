class Particle{
  PVector pos;
  float power;
  color col;
  
  Particle(PVector pos, float power, color col){
    this.pos = pos;
    this.power = power;
    this.col = col;
  }
  
  void update(ArrayList<Magnet> magnets){
    PVector sum = new PVector();
    for(Magnet magnet : magnets){
      PVector diff = PVector.sub(pos, magnet.pos);
      float poweredDst = diff.x*diff.x + diff.y*diff.y;//squared distance
      if(!usePrinciple){
        poweredDst = diff.x*diff.x*diff.x*diff.x + diff.y*diff.y*diff.y*diff.y;
      }
      diff.mult(power*magnet.power/poweredDst);//for easy visualize
      sum.add(diff);
    }
    pos.add(sum.setMag(partiR*2));//for efficient visualize
  }
  
  boolean valid(ArrayList<Magnet> magnets){
    boolean inWindow = pos.x >= 0 && pos.x < width && pos.y >= 0 && pos.y < height;
    boolean collide = false;
    for(Magnet magnet : magnets){
      PVector diff = PVector.sub(pos, magnet.pos);
      float sqrDst = diff.x*diff.x + diff.y*diff.y;
      if(sqrDst<magR*2*magR*2 && power*magnet.power < 0)collide = true;
    }
    return inWindow && (!collide);
  }
  
  void show(){
    fill(col);
    rect(pos.x-partiR, pos.y, partiR*2-partiR, partiR*2);
  }
}
