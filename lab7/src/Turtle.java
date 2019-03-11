/*

Carlos Roman Rivera - A01700820
Programming Languages
Lab 7 - Concurrency

*/

import static java.lang.Thread.interrupted;

public class Turtle implements Runnable {

    private int length;
    private int speed;

    public void run() {
        while (this.length > 0) {
            try {
                if (interrupted()) {
                    throw new InterruptedException();
                }
                this.length -= this.speed;
                if (this.length <= 0) {
                    return;
                } else {
                    System.out.printf("TURTLE: Ran %d feet. Missing %d feet.\n", this.speed, this.length);
                }
            } catch (InterruptedException e) {
                return;
            }
        }
    }

    Turtle(int speed, int length) {
        this.length = length;
        this.speed = speed;
    }

}
