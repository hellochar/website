package daily

import org.zhang.lib.MyPApplet
import org.zhang.lib.misc.Vec3
import processing.core._
import processing.opengl._
import peasy.{PeasyDragHandler, PeasyCam}
import controlP5.{ControllerInterface, ControlP5};

/**
 * Created by IntelliJ IDEA.
 * User: hellochar
 * Date: 9/10/11
 * Time: 11:51 AM
 */

class Sep10 extends MyPApplet with Savable { app =>

  import PConstants._, PApplet._, zhang.Methods.{PI => _, TWO_PI => _, map => _, _};
  import CP5._;
  type Path = Stream[Vec3]

  def makePath(start:Vec3, offset:Vec3 => Vec3):Path = Stream.iterate(start)(c => c + offset(c)*timeStep)
  def drawPath(path:Path) { beginShape(); path.foreach(vertex _); endShape(); }

  def offset(coords:Vec3) = { import coords._; Vec3(sigma*(y-x), x*(phi-z)-y, x*y-beta*z)}

  object CP5 {
    val cp5 = new ControlP5(app); cp5.setAutoDraw(false)
    private val sigmaControl = cp5.addSlider("sigma", 0, 25).linebreak(); sigmaControl.setValue(10);
    private val phiControl = cp5.addSlider("phi", 0, 100).linebreak(); phiControl.setValue(28f);
    private val betaControl = cp5.addSlider("beta", 0, 15).linebreak(); betaControl.setValue(8/3f);
    private val stepsControl = cp5.addSlider("steps", 10, 1e5.toInt).linebreak(); stepsControl.setValue(3000);
    private val dAxesControl = cp5.addButton("Draw Axes");

    def sigma = sigmaControl.getValue;
    def phi = phiControl.getValue;
    def beta = betaControl.getValue;
    def dAxes = dAxesControl.booleanValue()
    def steps = stepsControl.getValue.toInt
  }


  val timeStep = 5e-3f; //1e-1f diverges
  lazy val peasy = {
    val k = new PeasyCam(this, 100)
    //Now a mouse left-drag will rotate the camera around the subject,
    //a right drag will zoom in and out, and
    //a middle-drag will pan.

    // A double-click restores the camera to its original position.
    def excludeP5(ph:PeasyDragHandler) = {
      new PeasyDragHandler {
        def handleDrag(dx: Double, dy: Double) {
          if(!draggingP5)
            ph.handleDrag(dx, dy)
        }
      }
    }
    k.setLeftDragHandler(excludeP5(k.getRotateDragHandler))
    k.setRightDragHandler(excludeP5(k.getZoomDragHandler));
    k.setCenterDragHandler(excludeP5(k.getPanDragHandler))

    k
  }

  override def setup() {
    size(500, 500, OPENGL)
    peasy
  }

  override def draw() {
    background(0)
    if(dAxes) drawAxes(g, 20)
    noFill
    stroke(192, 192, 0)

    val path = makePath(Vec3(1), offset _).take(steps) //simulate for 1 second
    implicit def d2f(d:Double) = d.toFloat
    //for(x <- Range.Double(0, TWO_PI, TWO_PI / 20)) { pushMatrix(); translate(x, x*x, 30*sqrt(x)); rotateX(x.toFloat); drawPath(path); popMatrix(); }
    drawPath(path)

    peasy.beginHUD()
    cp5.draw()
    peasy.endHUD()
  }

  var draggingP5 = false;

  override def mousePressed() {
    def inCI(p:ControllerInterface) = zhang.Methods.isInRange(new PVector(mouseX, mouseY), p.getAbsolutePosition,
      PVector.add(p.getAbsolutePosition, new PVector(p.getWidth, p.getHeight))
    ) //>_< SO MUCH BOILING
    draggingP5 = cp5.getControllerList.exists(inCI _);
  }

  override def mouseReleased() {
    draggingP5 = false;
  }
}