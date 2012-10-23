-injars ..\\Daily.jar
-outjars Nov2b.jar
-libraryjars 'C:\Program Files\Java\jdk1.6.0_23\jre\lib\rt.jar'

-keep public class daily.nov.Nov2b

-dontpreverify
-ignorewarnings
-keeppackagenames controlP5

-keep public class processing.core.* extends processing.core.PGraphics

#controlP5 uses various gifs in the controlP5 folder, so the class names must be preserved.
-keepnames class controlP5.*

# Keep all registerXxxx() method callbacks in all classes
-keepclassmembers class ** {
  public void pre();
  public void draw();
  public void post();
  public void keyEvent(java.awt.event.KeyEvent);
  public void mouseEvent(java.awt.event.MouseEvent);
  public void size(int, int);
  public void stop();
  public void dispose();
}

#======================KEEP SCALA STUFF=======================
-keepclassmembers class * {
    ** MODULE$;
}
