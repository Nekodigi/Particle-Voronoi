float dstPow = 2;//maginetic distance factor, we generary use 2 for magnetic field but 4 is good for this situation
float magR = 2;//magnet radius
float partiR = 0.5;//particle radius
int spf = 10;//particle spawn per frame
int nm = 10;//number of magnet 100
float pS = 2;//point size
float lS = 1;//line size
boolean useSecondNearest = true;//use second nearest magnet
//if it true we can get curved good trail and some interesting clack.
//if it false we can get accurate and simple one.

ArrayList<Particle> particles = new ArrayList<Particle>();
ArrayList<Magnet> magnets = new ArrayList<Magnet>();

void setup(){
  //fullScreen();
  blendMode(ADD);
  size(500, 500);
  colorMode(HSB, 360, 100, 100);
  //ortho();
  background(0);
  translate(width/2, height/2);
  stroke(50);
  //noFill();
  //voronoi2D.voronoi.delaunay.show();
  for(int i=0; i<nm; i++){                      
    magnets.add(new Magnet(new PVector(random(0, width), random(0, height)), 1, color(100+random(50), 100, 100, 30)));
  }
}

void keyPressed(){
  if(key == 'r'){
  }
}

void draw(){
  noStroke();
  for(Magnet magnet : magnets){
    if(magnet.power>0)magnet.genParticles(magnet.power);
  }
  for(Particle particle : particles){
    particle.update(magnets);
  }
  for(Particle particle : particles){
    particle.show();
  }
  for(Magnet magnet : magnets){
    magnet.show();
  }
  for(int i=particles.size()-1; i>=0; i--){
    Particle particle = particles.get(i);
    if(!particle.valid(magnets)){
    particles.remove(i);
    }
  }
}
