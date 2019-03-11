/*

Carlos Roman Rivera - A01700820
Programming Languages
Lab 7 - Concurrency

*/

import java.util.Scanner;

public class Main {

    public static void main(String[] args) {

        int rabbitRest, raceLength, turtleSpeed;
        Scanner s = new Scanner(System.in);
        Thread r;

        do {
            System.out.print("Race length in feet: ");
            raceLength = s.nextInt();

            System.out.print("Rabbit sleep in milliseconds: ");
            rabbitRest = s.nextInt();

            System.out.print("Turtle speed in feet: ");
            turtleSpeed = s.nextInt();

            r = new Thread(new Race(raceLength, rabbitRest, turtleSpeed));
            r.start();

            try {
                r.join();
            } catch (InterruptedException e) {
                System.out.println("Race was interrupted.");
            }

            System.out.println();

            System.out.print("Test new parameters? (true/false): ");

        } while (s.nextBoolean()) ;



    }
}
