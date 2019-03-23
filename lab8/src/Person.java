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
        try {
            Thread.sleep(random.nextInt(5000) + 5000);
            garden.leaveGarden(this.name);
        } catch (InterruptedException e) { }
    }
}