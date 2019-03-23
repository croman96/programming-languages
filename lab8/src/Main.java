import java.util.Scanner;

public class Main {

    public static void main(String[] args) {

        Scanner scan = new Scanner(System.in);  // Input
        Garden garden = new Garden();           // Garden
        int produceEast, produceWest;           // Number of people to access through each door.

        System.out.printf("How many people will go through the East door?\nInt: ");
        produceEast = scan.nextInt();

        System.out.printf("How many people will go through the West door?\nInt: ");
        produceWest = scan.nextInt();

        (new Thread(new Door(garden, produceEast, "East"))).start();
        (new Thread(new Door(garden, produceWest, "West"))).start();

    }

}
