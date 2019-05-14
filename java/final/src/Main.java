/*

    Carlos Roman Rivera - A01700820
    Programming Languages - Final Exam
    Aliens!

*/

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import javax.imageio.ImageIO;
import java.util.Scanner;
import java.util.concurrent.*;

public class Main extends RecursiveAction {

    private BufferedImage img;  // The image to be parsed.
    private int start;          // Boundary parameter.
    private int end;            // Boundary parameter.
    private int[] sumArr;       // Array used to store sum across threads.


    Main(BufferedImage img, int start, int end, int[] sumArr) {
        this.img = img;
        this.start = start;
        this.end = end;
        this.sumArr = sumArr;
    }

    // We compute the pixels sum of an entire row.

    protected void computeDirectly(){

        int numCols = img.getWidth();

        int sum = 0;

        for (int j = 0; j < numCols; j++) {
            int rgb = img.getRGB(j, start);                     // Get RGB values of the pixel.

            int r = (rgb>>16)&0xff;
            int g = (rgb>>8)&0xff;
            int b = rgb&0xff;

            sum += (r+g+b);                                     // Sum RGB values to accumulator.
        }

        sumArr[start] = sum;                                    // Save on current threads position.

    }

    @Override
    protected void compute() {
        if(end - start == 1) {
            computeDirectly();                                  // Chunk of work is small enough to compute.
            return;
        } else {
            int split = (end + start) >>> 1;                    // Split into halves. Invoke separately.
            invokeAll(new Main(img, start, split, sumArr),
                    new Main(img, split, end, sumArr));
        }
    }

    public static void main(String[] args) throws IOException {

        int total_concurrent = 0, total_sequential = 0;         // Save sum for both methods.
        long start_concurrent, end_concurrent;                  // Time for concurrent execution.

        Scanner s = new Scanner(System.in);                     // Instance scanner object for parsing user's input.

        System.out.print("Full path of the image: ");

        String read_path = s.nextLine();                        // example: /Users/croman/Downloads/black.jpg

        BufferedImage img = ImageIO.read(new File(read_path));

        int numRows = img.getHeight();

        int[] sumArr = new int[numRows];                        // Array to store concurrent results. One per row.

        start_concurrent = System.currentTimeMillis();          // Start measuring concurrent time.

        Main m = new Main(img, 0, numRows, sumArr);       // Instantiate object to parallelize task.

        ForkJoinPool pool = new ForkJoinPool();                 // Create Thread Pool

        pool.invoke(m);                                         // Parallel execution.

        end_concurrent = System.currentTimeMillis();            // Stop measuring concurrent time.

        for (int i = 0 ; i < numRows ; i++) {
            total_concurrent += sumArr[i];                      // Sum all partial results into one.
        }

        System.out.println("Pixel Sum: " + total_concurrent);
        System.out.println("Execution Time: " + (end_concurrent - start_concurrent));

    }
}
