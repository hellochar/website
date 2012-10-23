-injars ..\Daily.jar
-outjars Sep10.jar
-libraryjars 'C:\Program Files\Java\jdk1.6.0_23\jre\lib\rt.jar'

    -keep public class daily.Sep10

    -dontpreverify
    -dontwarn
    -dontobfuscate

    -keep public class * extends processing.core.PGraphics

    # Keep Proscene
    #-keepclasseswithmembers public class remixlab.proscene.* {
    #    public <methods>;
    #}

    #-keepclasseswithmembers public class controlP5.* {
    #    public <methods>;
    #}

    # Keep all registerXxxx() method callbacks in all classes
    -keepclassmembers class * {
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

    -keepclassmembernames class scala.concurrent.forkjoin.ForkJoinPool {
        long eventCount;
        int  workerCounts;
        int  runControl;
        scala.concurrent.forkjoin.ForkJoinPool$WaitQueueNode syncStack;
        scala.concurrent.forkjoin.ForkJoinPool$WaitQueueNode spareStack;
    }

    -keepclassmembernames class scala.concurrent.forkjoin.ForkJoinWorkerThread {
        int base;
        int sp;
        int runState;
    }

    -keepclassmembernames class scala.concurrent.forkjoin.ForkJoinTask {
        int status;
    }

    -keepclassmembernames class scala.concurrent.forkjoin.LinkedTransferQueue {
        scala.concurrent.forkjoin.LinkedTransferQueue$PaddedAtomicReference head;
        scala.concurrent.forkjoin.LinkedTransferQueue$PaddedAtomicReference tail;
        scala.concurrent.forkjoin.LinkedTransferQueue$PaddedAtomicReference cleanMe;
    }