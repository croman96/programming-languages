/*

    Carlos Roman Rivera - A01700820
    Programming Languages - Lab 8

*/

import java.util.Scanner;

public class Main {

    public static void main(String[] args) {

        Scanner scan = new Scanner(System.in);  // Scanner instance to process input.
        Garden garden = new Garden();           // Garden instance to share amongst doors.
        int produceEast, produceWest;           // Number of people to access through each door.

        System.out.printf("How many people will go through the East door?\nInt: ");
        produceEast = scan.nextInt();

        System.out.printf("How many people will go through the West door?\nInt: ");
        produceWest = scan.nextInt();

        (new Thread(new Door(garden, produceEast, "East"))).start();    // East Door
        (new Thread(new Door(garden, produceWest, "West"))).start();    // West Door

    }

}
