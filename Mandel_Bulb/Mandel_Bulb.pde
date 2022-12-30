import peasy.*;

int DIM = 64;
PeasyCam cam;
ArrayList<PVector> mandelbulb = new ArrayList<PVector>();

class Spherical {
  float r, theta, phi;
  Spherical(float r, float theta, float phi){
    this.r = r;
    this.theta = theta;
    this.phi = phi;
  }
}

Spherical spherical(float x, float y, float z) {
  float r = sqrt(pow(x, 2)+pow(y, 2)+pow(z, 2));
  float theta = atan2(sqrt(pow(x, 2)+pow(y, 2)), z);
  float phi = atan2(y, x);
  return new Spherical(r, theta, phi);
}

void setup() {
  size(600, 600, P3D);
  windowMove(10, 10);
  cam = new PeasyCam(this, 500);
  
  for(int i=0; i<DIM; i++){
    for(int j=0; j<DIM; j++){
      
      boolean edge = false;
      
      for (int k=0; k<DIM; k++){
        float x = map(i, 0, DIM, -1, 1);
        float y = map(j, 0, DIM, -1, 1);
        float z = map(k, 0, DIM, -1, 1);
        
        PVector zeta = new PVector(0, 0, 0);
        
        int n = 16;
        
        int maxIterations = 100;
        int iteration = 0;
        while (true) {
          Spherical c = spherical(zeta.x, zeta.y, zeta.z);
        
          float newx = pow(c.r, n) * sin(c.theta*n) * cos(c.phi*n);
          float newy = pow(c.r, n) * sin(c.theta*n) * sin(c.phi*n);
          float newz = pow(c.r, n) * cos(c.theta*n);
          
          zeta.x = newx + x;
          zeta.y = newy + y;
          zeta.z = newz + z;
          
          iteration++;
          
          if (c.r > 16) {
            if (edge) {
              edge = false;
            }
            break;
          }
          
          if (iteration > maxIterations) {
            if (!edge) {
              edge = true;
              mandelbulb.add(new PVector(x*100, y*100, z*100));
            }
            break;
          }
        }
      }
    }
  }
}

void draw() {
  background(0);
  
  for(PVector v: mandelbulb){
    stroke(255);
    strokeWeight(2);
    point(v.x, v.y, v.z);
  }
}
