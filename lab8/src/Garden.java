/*

    Carlos Roman Rivera - A01700820
    Programming Languages - Lab 8

*/

public class Garden {
    private int attendance = 0;

    public synchronized void leaveGarden(String name) {
        attendance--;                                                                   // Register departure.
        System.out.printf("%s just left.\t\tAttendance: %d\n", name, attendance);       // Illustrative purpose.
    }

    public synchronized void enterGarden(String name) {
        attendance++;                                                                   // Register attendance.
        System.out.printf("%s just entered.\tAttendance: %d\n", name, attendance);      // Illustrative purpose.
        (new Thread(new Person(this, name))).start();                           // A person entered, create it.
    }

}