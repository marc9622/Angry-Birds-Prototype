float drawLength = 1; // Trækkelængden
float drawDegree = 45; // Trækkegrader

float mass = 1; // Fuglens masse
float gravity = 9.82;

float energy; //Affyringsenergi
float slope; //Affyringshældning

float u, v; // Fuglens x- og y-hastighed
float uStart, vStart; // Fuglens starthastighed

float x, y; // Fuglens position

float time; // Tidsintervallet mellem frames

float levelYStart = 20f; // Banens start højde 0-100
float levelSlope = -5f; // Banens hældning
float levelGrowthRate = 1f; // Banens væksthastighed

float xScale = 10, yScale = 50;

float drawGroundResolution = 50;

void setup() {
  setupNumber();
  
  frameRate(60);
  size(1280, 720);
  surface.setResizable(true);
}

void setupNumber() {
  energy = calculateEnergy(drawLength);
  slope = calculateSlope(drawDegree);
  
  uStart = startUVelocity(energy, slope, mass);
  vStart = startVVelocity(uStart, slope);
}

void draw() {
  background(0,0,0);
  drawBird();
  drawGround();
  
  x = calculateX(time);
  y = calculateY(time);
  
  time += 0.01f;
}

void drawBird() {
  circle(x, height - y,10);
}

float calculateEnergy(float l) {
  return 50f * pow(l,2);
}

float calculateSlope(float d) {
  return tan(radians(d));
}

float startUVelocity(float E, float A, float m) {
  return sqrt(
    (2f * E) /
    (m * (1 + pow(A,2)))
  );
}

float startVVelocity(float U, float A) {
  return A * U;
}

float calculateX(float t) {
  return uStart * t;
}

float calculateY(float t) {
  return -(0.5f) * gravity * pow(t,2) + vStart * t + levelYStart;
}

void drawGround() {  
  for (float x = 0; x < 15; x += 15f / width) {
    stroke(255,255,255);
            
    line(x * (width / 15), height, x * (width / 15), height - ground(x));
  }
}

float ground(float x) {
  
  return levelGrowthRate * pow(x,2) + levelSlope * x + levelYStart;
}
