/*

Carlos Roman Rivera - A01700820
Programming Languages
Lab 7 - Concurrency

*/

import java.util.Random;

public class Rabbit implements Runnable{

    private int rest;
    private int length;

    public void run() {
        Random r = new Random();
        int pace;
        while (this.length > 0) {
            try {
                pace = r.nextInt(501) + 500; // random [500 - 1000]
                this.length -= pace;
                if (this.length <= 0) {
                    return;
                } else {
                    System.out.printf("RABBIT: Ran %d feet. Missing %d feet. Resting %d ms.\n", pace, this.length, this.rest);
                    Thread.sleep(this.rest);
                }
            } catch (InterruptedException e) {
                return;
            }
        }

    }

    Rabbit(int rest, int length) {
        this.rest = rest;
        this.length = length;
    }

}
