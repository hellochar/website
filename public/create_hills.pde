float offset = random(1e5);
float animMillis = 600; //the total number of milliseconds this should go for

void setup() {
  size(
    $('#content').width(),
    Math.max(
      $('#content').height(),
      $(document).height()-45
    )
  );
  noSmooth();
}

void draw() { 
  background(0, 0);
  strokeWeight(1);
  colorMode(HSB);
  float separation = ((1+Math.sin(offset/28000 * TWO_PI)) / 2 * 15 + 15);
  float hueOffset = (255 * offset / 10000.0) % 255; //100 seconds per oscillation of hue
  for(int z = 0; z < 20; z++) {
    noFill(); stroke(z*2+hueOffset, 200, 255);
    beginShape();
    for(int x = 0; x < lerp(0, width, sqrt(norm(millis(), 0, animMillis))); x += 5) {
      vertex(x, (noise(x/1000, z/100, offset/10000.0)-.2)*height+separation/(.1*x)*z);
    }
    endShape();
  }
  if(millis() > animMillis) {
    noLoop();
  }
}
