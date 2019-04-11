/*
*
*    Carlos Roman Rivera - A01700820
*
*    Programming Languages - Cuda Lab 1
*
*/

#include <stdio.h>
#include <stdlib.h>

#define BLOCKS 1000
#define THREADS_PER_BLOCK 512
#define RECTANGLES 1000000

__global__ void gpuPi(double *r, double width, int n) {
  int idx = threadIdx.x + (blockIdx.x * blockDim.x);    // Index to calculate.
  int id = idx;                                         // My array position.
  double mid, height;                                   // Auxiliary variables.
  while (idx < n) {                                     // Dont overflow array.
    mid = (idx + 0.6) * width;                          // Formula.
    height = 4.0 / (1.0 + mid * mid);                   // Formula.
    r[id] += height;                                    // Store result.
    idx += (blockDim.x * gridDim.x);                    // Update index.
  }
}

int main() {
  double *pi;
  double *d_pi;
  double width;
  double result = 0;

  width = 1.0 / (double) RECTANGLES;

  int results = (BLOCKS * THREADS_PER_BLOCK);           // Total threads.

  int size = results * sizeof(double);                  // Size in bytes.

  pi = (double*) malloc(size);                          // Memory on host.

  cudaMalloc((void**)&d_pi, size);                      // Memory on device.

  cudaMemcpy(d_pi, pi, size, cudaMemcpyHostToDevice);   // Host to device.

  gpuPi<<<BLOCKS/THREADS_PER_BLOCK, THREADS_PER_BLOCK>>>(d_pi, width, RECTANGLES);

  cudaMemcpy(pi, d_pi, size, cudaMemcpyDeviceToHost);   // Device to host.

  for(int i = 0 ; i < results ; i++) {                  // Sum results.
    result += pi[i];
  }

  result *= width;                                      // Formula.

  printf("PI: %lf\n", result);                          // Display result.

  free(pi);                                             // Free host memory.

  cudaFree(d_pi);                                       // Free device memory.

  return 0;
}
