-injars ..\Daily.jar
-outjars Dec02b.jar

-libraryjars 'C:\Program Files\Java\jdk1.6.0_23\jre\lib\rt.jar'

-keeppackagenames controlP5
-dontpreverify
-ignorewarnings


-keep public class daily.Dec02b

-keep public class processing.core.* extends processing.core.PGraphics

# Keep all registerXxxx() method callbacks in all classes
-keepclassmembers class ** {
    public void pre();
    public void draw();
    public void post();
    public void keyEvent(java.awt.event.KeyEvent);
    public void mouseEvent(java.awt.event.MouseEvent);
    public void size(int,int);
    public void stop();
    public void dispose();
}

# ======================KEEP SCALA STUFF=======================
-keepclassmembers class * {
    ** MODULE$;
}

-keep class ** extends org.zhang.parse.expr.Expr

# controlP5 uses various gifs in the controlP5 folder, so the class names must be preserved.
-keep,allowshrinking class controlP5.*
