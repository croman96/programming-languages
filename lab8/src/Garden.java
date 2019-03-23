public class Garden {
    private int attendance = 0;

    public synchronized void leaveGarden(String name) {
        attendance--;
        System.out.printf("%s just left.\t\tAttendance: %d\n", name, attendance);
    }

    public synchronized void enterGarden(String name) {
        attendance++;
        System.out.printf("%s just entered.\tAttendance: %d\n", name, attendance);
        (new Thread(new Person(this, name))).start();
    }

}