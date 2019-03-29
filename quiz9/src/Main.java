import java.util.Random;
import java.util.Scanner;
import java.util.concurrent.*;

public class Main extends RecursiveAction {

    private int [][] matrixA;
    private int [][] matrixB;
    private int [][] matrixResult;
    private int start;
    private int end;
    private int operation;


    Main(int [][] matrixA, int [][] matrixB, int [][] matrixResult, int start, int end, int operation) {
        this.matrixA = matrixA;
        this.matrixB = matrixB;
        this.matrixResult = matrixResult;
        this.start = start;
        this.operation = operation;
        this.end = end;
    }

    protected void computeDirectly(){
        for(int i = 0 ; i < end ; i++) {
            if(operation == 1) {           // if we must perform an addition.
                matrixResult[start][i] = matrixA[start][i] + matrixB[start][i];
            } else if (operation == 2) {   // if we must perform a substraction.
                matrixResult[start][i] = matrixA[start][i] - matrixB[start][i];
            }
        }
    }

    @Override
    protected void compute() {
        if(end - start == 1) {
            computeDirectly();      // perform operation between 1 row of both matrices.
            return;
        } else {
            int split = (end + start) >>> 1;
            invokeAll(new Main(matrixA, matrixB, matrixResult, start, split, operation), new Main(matrixA, matrixB, matrixResult, split, end, operation));
        }
    }

    public static void main(String[] args) {

        Scanner s = new Scanner(System.in);
        Random r = new Random();

        long startTime;
        long endTime;
        long elapsedTime;

        int operation;
        int end = 50;

        int [][] mA = new int [end][end];
        int [][] mB = new int [end][end];
        int [][] mR = new int [end][end];

        // Initialize matrixA

        for(int i = 0; i < end ; i++) {
            for(int j = 0 ; j < end ; j++) {
                mA[i][j] = r.nextInt(500);
            }
        }

        // Initialize matrixB

        for(int i = 0; i < 50 ; i++) {
            for(int j = 0 ; j < 50 ; j++) {
                mB[i][j] = r.nextInt(500);
            }
        }

        // Initialize matrixR

        for(int i = 0; i < end ; i++) {
            for(int j = 0 ; j < end ; j++) {
                mR[i][j] = 0;
            }
        }

        System.out.printf("Operation to perform:\n1. Addition\n2. Substraction\nAnswer = ");

        operation = s.nextInt();

        Main m = new Main(mA, mB, mR,0, end, operation);

        ForkJoinPool pool = new ForkJoinPool();

        System.out.println("Start execution.");

        startTime = System.currentTimeMillis();

        pool.invoke(m);

        endTime = System.currentTimeMillis();

        elapsedTime = endTime - startTime;

        System.out.printf("Finished execution after %d seconds.\n", elapsedTime);

    }

}
