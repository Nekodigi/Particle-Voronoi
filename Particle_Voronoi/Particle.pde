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
    Magnet mag1 = null;//nearest magnet
    Magnet mag2 = null;//second nearest magnet
    float minSqDst1 = Float.POSITIVE_INFINITY;//nearest square distance
    float minSqDst2 = Float.POSITIVE_INFINITY;//second nearest square distance
    for(Magnet magnet : magnets){
      PVector diff = PVector.sub(magnet.pos, pos);
      float sqDst = diff.x*diff.x + diff.y*diff.y;//for high speed processing
      if(minSqDst1 > sqDst){
        minSqDst1 = sqDst;
        mag1 = magnet;
      }else if(minSqDst2 > sqDst){
        minSqDst2 = sqDst;
        mag2 = magnet;
      }
    }
    if(mag1 == null || mag2 == null)return;
    ArrayList<Magnet> selectedMag = new ArrayList<Magnet>();
    selectedMag.add(mag1);
    if(useSecondNearest){
      selectedMag.add(mag2);
    }
    for(Magnet magnet : selectedMag){
      PVector diff = PVector.sub(pos, magnet.pos);
      float poweredDst = pow(diff.x, dstPow) + pow(diff.y, dstPow);
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
    ellipse(pos.x, pos.y, partiR*2, partiR*2);
  }
}
