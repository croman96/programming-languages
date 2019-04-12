/*

    Carlos Roman Rivera - A01700820
    Programming Languages - Lab 9

*/

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import javax.imageio.ImageIO;
import java.util.Scanner;
import java.util.concurrent.*;

public class Main extends RecursiveAction {

    private BufferedImage img;
    private int start;
    private int end;


    Main(BufferedImage img, int start, int end) {
        this.img = img;
        this.start = start;
        this.end = end;
    }

    protected void computeDirectly(){

        int numCols = img.getWidth();

        for (int j = 0; j < numCols; j++) {
            int rgb = img.getRGB(j, start);

            int a = (rgb>>24)&0xff;
            int r = (rgb>>16)&0xff;
            int g = (rgb>>8)&0xff;
            int b = rgb&0xff;

            int avg = (r+g+b) / 3;

            rgb = (a<<24) | (avg<<16) | (avg<<8) | avg;

            img.setRGB(j, start, rgb);
        }
    }

    @Override
    protected void compute() {
        if(end - start == 1) {
            computeDirectly();                                  // Chunk of work is small enough to compute.
            return;
        } else {
            int split = (end + start) >>> 1;                    // Split into halves. Invoke separately.
            invokeAll(new Main(img, start, split),
                      new Main(img, split, end));
        }
    }

    public static void main(String[] args) throws IOException {

        Scanner s = new Scanner(System.in);                     // Instance scanner object for parsing user's input.

        long start_sequential, end_sequential, start_parallel, end_parallel;

        System.out.print("Full path of the image to be processed: ");

        String read_path = s.nextLine();                        // example: /Users/croman/Downloads/natalie.jpg

        System.out.print("Full path for the new images to be stored: ");

        String write_path = s.nextLine();                       // example: /Users/croman/Downloads/

        BufferedImage img = ImageIO.read(new File(read_path));

        int numRows = img.getHeight();
        int numCols = img.getWidth();

        System.out.println("Start sequential...");

        start_sequential = System.currentTimeMillis();          // Start measuring sequential time.

        for (int i = 0; i < numRows; i++) {                     // For each row.
            for (int j = 0; j < numCols; j++) {                 // For each column.
                int rgb = img.getRGB(j, i);                     // Get current RGB value.

                int a = (rgb>>24)&0xff;                         // Split integer into its components using bitshifting.
                int r = (rgb>>16)&0xff;
                int g = (rgb>>8)&0xff;
                int b = rgb&0xff;

                int avg = (r+g+b)/3;                            // RGB average used to transform to greyscale.

                rgb = (a<<24) | (avg<<16) | (avg<<8) | avg;     // Return to format.
                img.setRGB(j, i, rgb);                          // Set new value for current pixel.

            }
        }

        end_sequential = System.currentTimeMillis();            // Stop measuring sequential time.

        System.out.printf("Finished sequential after %d ms.\n", end_sequential - start_sequential);

        ImageIO.write(img, "png", new File(write_path + "/sequential.png"));

        img = ImageIO.read(new File(read_path));                // Reload the original photo.

        Main m = new Main(img, 0, numRows);               // Instantiate object to parallelize task.

        ForkJoinPool pool = new ForkJoinPool();                 // Create Thread Pool

        System.out.println("Start parallel...");

        start_parallel = System.currentTimeMillis();            // Start measuring parallel time.

        pool.invoke(m);                                         // Parallel execution.

        end_parallel = System.currentTimeMillis();              // Stop measuring parallel time.

        System.out.printf("Finished parallel after %d ms.\n", end_parallel - start_parallel);

        ImageIO.write(img, "png", new File(write_path + "/parallel.png"));

    }
}
