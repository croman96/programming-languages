import java.util.Random;

public class Door implements Runnable {
    private Garden garden;
    private int producePeople;
    private String doorId;

    Door(Garden garden, int producePeople, String doorId) {
        this.garden = garden;
        this.producePeople = producePeople;
        this.doorId = doorId;
    }

    public void run() {
        Random random = new Random();

        for(int i = 0 ; i < producePeople ; i++) {
            try {
                Thread.sleep(random.nextInt(5000));
                garden.enterGarden(doorId + "-" + (i+1));
            } catch (InterruptedException e) {
                return;
            }
        }

    }

}