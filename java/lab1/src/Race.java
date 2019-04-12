/*

Carlos Roman Rivera - A01700820
Programming Languages
Lab 7 - Concurrency

*/

public class Race implements Runnable{

    private int raceLength;
    private int rabbitRest;
    private int turtleSpeed;

    public void run() {

        System.out.printf("Race length: %d feet. Rabbit sleep: %d ms. Turtle speed: %d feet.\n", raceLength, rabbitRest, turtleSpeed);

        Thread rabbit;
        Thread turtle;

        rabbit = new Thread(new Rabbit(this.rabbitRest, this.raceLength));
        turtle = new Thread(new Turtle(this.turtleSpeed, this.raceLength));

        rabbit.start();
        turtle.start();

        while (true) {
            if(!turtle.isAlive()) {
                System.out.println("TURTLE WINS, BABY.");
                rabbit.interrupt();
                try {
                    rabbit.join();
                    break;
                } catch (InterruptedException e) {
                    return;
                }
            } else if (!rabbit.isAlive()) {
                System.out.println("RABBIT WINS, BABY.");
                turtle.interrupt();
                try {
                    turtle.join();
                    break;
                } catch (InterruptedException e) {
                    return;
                }
            }
        }

    }

    Race(int raceLength, int rabbitRest, int turtleSpeed) {
        this.raceLength = raceLength;
        this.rabbitRest = rabbitRest;
        this.turtleSpeed = turtleSpeed;
    }

}
