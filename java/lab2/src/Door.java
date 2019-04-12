/*

    Carlos Roman Rivera - A01700820
    Programming Languages - Lab 8

*/

import java.util.Random;

public class Door implements Runnable {
    private Garden garden;
    private int producePeople;
    private String doorId;

    Door(Garden garden, int producePeople, String doorId) {
        this.garden = garden;                   // Shared instance of the garden.
        this.producePeople = producePeople;     // Amount of people that this door should produce.
        this.doorId = doorId;                   // Door's ID
    }

    public void run() {
        Random random = new Random();
        for(int i = 0 ; i < producePeople ; i++) {                     // Create the established amount of people.
            try {
                Thread.sleep(random.nextInt(5000));
                garden.enterGarden(doorId + "-" + (i+1));       // Register that a person entered the garden.
            } catch (InterruptedException e) {
                return;
            }
        }

    }

}