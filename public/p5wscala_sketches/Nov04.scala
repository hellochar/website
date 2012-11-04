package daily

import processing.core._
import org.zhang.lib.{HasMV, MyPApplet}
import zhang.Camera
import org.zhang.geom.Vec2

class Nov04 extends MyPApplet with Savable {

  import PApplet._;
  import PConstants._;

  lazy val nouns = loadStrings("nounlist.txt")
  lazy val cam = new Camera(this)

  class Thing(var pos:Vec2, var speed:Float = 10f, var dir:Float = 0, val name:String = "") {
    def draw() {
      noStroke();
      fill(0, 255, 0)
      rect(pos, 15, 15)
      stroke(0)
      textAlign(CENTER, BOTTOM);
      textSize(20);
      text(name, pos.x, pos.y - 15);
    }
    def run() {
      dir = pos.angleTo(me.pos)
      pos += Vec2.fromPolar(speed, dir)
    }
  }

  object me extends Thing(Vec2(random(-5000, 5000), random(-5000, 5000)), 10, 0, "you!") {
    override def draw() {
      noStroke()
      fill(255, 0, 0)
      ellipse(pos, 40, 40)
    }
    override def run() {
      val nextPos = pos + mapping.filterKeys(keys.isPressed _).values.fold(Vec2())(_ + _) * 6
      if(onGround(nextPos.x, nextPos.y)) pos = nextPos
    }
  }

  lazy val keys = new zhang.MultiKeyListener()

  import java.awt.event.KeyEvent._
  val mapping = Map(
    VK_W -> Vec2(0, -1),
    VK_S -> Vec2(0, 1),
    VK_A -> Vec2(-1, 0),
    VK_D -> Vec2(1, 0))

  var things = Set[Thing](me)

  override def setup() {
    size(1024, 700)
    cam.noUi()
    addKeyListener(keys)
    (0 until 1000).foreach { i =>
      things += new Thing(me.pos + Vec2(random(-width*10, width*10), random(-height*10, height*10)), 3, 0, nouns(randi(nouns.length - 1)) + "s")
    }
    rectMode(CENTER)
  }

  val scale = 1000f
  val timeScale = 1e4f
  var killed = List[String]()

  def thresh = max(.5f, 1 / (millis()/10000f + 1))
  def fn(x:Float, y:Float) = noise(x/scale, y/scale, millis() / timeScale)
  def onGround(x:Float, y:Float) = fn(x, y) < thresh

  import zhang.Methods.{roundToNearest, floorToNearest, ceilToNearest}

  var dead = false
  var deadTime = 0f;

  override def draw() {
    if(dead) {
      resetMatrix()
      background(0)
      fill(255); stroke(255); textSize(60); textAlign(CENTER, TOP)
      if(killed.contains(me.name)) {
        text("YOU KILLED YOURSELF!", width/2, 0)
      } else {
        text("YOU LOST", width/2, 0)
      }
      textSize(14)
      rectMode(CORNER)
      textAlign(LEFT, TOP)
      text((killed - "you!").mkString("You killed " + (killed.length) + ": ", ", ", "!"), 0, 114, width, height)

      text("You lasted " + deadTime/1000f + " seconds!", 0, height*2/3);
      return
    }

    things foreach (_.run())

    cam.setCenter(me.pos.x, me.pos.y)
    cam.translate(mouseX - width/2, mouseY - height/2)

    background(255)
    for(x <- (0 until width+50 by 25).map(x => floorToNearest(cam.modelX(x), 25));
        y <- (0 until height+50 by 25).map(y => floorToNearest(cam.modelY(y), 25))
       ) {
      val sample = fn(x, y)
      if(onGround(x, y)) {
        val b = sample * 255
        noStroke(); fill(b, b/2, b/3)
        val closeness = thresh - sample //0 = right at the limit
        rect(x, y, max(closeness * 25, 25), max(closeness * 25, 25))
      }
    }
    things foreach (_.draw())

    if(mousePressed) {
      val newThings = things.filter(t => t.pos.distTo(mouseVec) > 50)
      killed ++= things.filterNot(newThings.contains _).map(x => x.name)
      things = newThings
      noStroke()
      fill(192, 112, 50)
      ellipse(mouseVec, Vec2(100))
    }

    dead |= (things - me).exists(p => p.pos.distTo(me.pos) < 20) || !things.contains(me)
    if(dead) {
      deadTime = millis()
    }

    pollSave() //check if the screen should be saved
  }

  override def mouseVec = Vec2(cam.modelX(mouseX), cam.modelY(mouseY))

  override def keyPressed() {
    super.keyPressed(); //pressing space toggles a boolean variable to save the screen
  }
}