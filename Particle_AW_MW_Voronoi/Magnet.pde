class Magnet{
  PVector pos;
  float power;
  color col;
  float aw;//add weight
  float mw;//multiplicate weight
  
  Magnet(PVector pos, float power, color col){
    this.pos = pos;
    this.power = power;
    this.col = col;
    this.aw = random(awMin, awMax);
    this.mw = random(mwMin, mwMax);
  }
  
  void genParticles(float power){
    particles.add(new Particle(pos.copy().add(PVector.random2D().mult(magR-partiR)), power, col)); 
  }
  
  void show(){
    fill(col);
    ellipse(pos.x, pos.y, magR*2, magR*2);
  }
}
