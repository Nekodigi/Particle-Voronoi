//based on this code https://github.com/Scrawk/Hull-Delaunay-Voronoi
int numVertices = 100;//200
float size = 200;//500
boolean usePrinciple = false;//squared distance for magnetic field in principle but power 4 is good for this situation
float magR = 2;//magnet radius
float partiR = 0.5;//particle radius
float spf = 10;//spawn per frame
boolean mode3D = false;
float pS = 2;//point size
float lS = 1;//line size
int iter = 10;//simulation iteration

ArrayList<Particle> particles = new ArrayList<Particle>();
ArrayList<Magnet> magnets = new ArrayList<Magnet>();

ExampleVoronoi voronoi2D = new ExampleVoronoi(2);

void setup(){
  //fullScreen();
  blendMode(ADD);
  size(500, 500);
  colorMode(HSB, 360, 100, 100);
  //ortho();
  background(0);
  translate(width/2, height/2);
  stroke(50);
  voronoi2D.voronoi.show();
  //noFill();
  //voronoi2D.voronoi.delaunay.show();
  for(Vertex v : voronoi2D.voronoi.delaunay.vertices){                          //                ~100
    magnets.add(new Magnet(new PVector(v.pos[0]+width/2, v.pos[1]+height/2), 1, color(random(50), 100, 100, 30)));
  }
  //on or off, both are good
  for(Simplex s : voronoi2D.voronoi.delaunay.simplexes){//get all voronoi vertices          //                ~100
    //magnets.add(new Magnet(new PVector(s.circumC[0]+width/2, s.circumC[1]+height/2), -1, color(200+random(50), 100, 100, 30)));
  }
}

void keyPressed(){
  if(key == 'r'){
    voronoi2D = new ExampleVoronoi(2);
  }
  if(key == 'm'){
    mode3D = !mode3D;
  }
}

void draw(){
  noStroke();
  for(int it=0; it<iter; it++){
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
}
