/*

    Carlos Roman Rivera - A01700820
    Programming Languages - Lab 8

*/

import java.util.Random;

public class Person implements Runnable {
    private Garden garden;
    private String name;

    Person(Garden garden, String name) {
        this.garden = garden;
        this.name = name;
    }

    public void run() {
        Random random = new Random();
        int sleepTime;
        try {
            sleepTime = random.nextInt(5000) + 5000;         // Time to spend inside the garden.
            Thread.sleep(sleepTime);                                // Spend time doing cool stuff.
            garden.leaveGarden(this.name);                          // Ask to leave.
        } catch (InterruptedException e) { }
    }
}