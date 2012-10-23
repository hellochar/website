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
  float separation = (1+Math.sin(millis()/28000 * TWO_PI)) / 2 * 15 + 15;
  float hueOffset = 255 * millis() / 10000.0; //100 seconds per oscillation of hue
  for(int z = 0; z < 20; z++) {
    noFill(); stroke(z*2+hueOffset, 200, 255);
    beginShape();
    for(int x = 0; x < width; x += 5) {
      vertex(x, (noise(x/1000, z/100, millis()/10000.0)-.2)*height+separation*z);
    }
    endShape();
  }
}
