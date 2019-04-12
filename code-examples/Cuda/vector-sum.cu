#include <stdio.h>
#include <stdlib.h>

#define N 10
#define THREADS_PER_BLOCK 10

__global__ void gpuSum(int *a, int *b, int *c, int n) {
  int idx = threadIdx.x + (blockIdx.x * blockDim.x);
  while (idx < n) {
    c[idx] = a[idx] + b[idx];
    idx += blockDim.x * gridDim.x;
  }
}

void fill_matrix(int *arr) {
  for (int i = 0 ; i < N ; i++) {
    for (int j = 0 ; j < N ; j++) {
      arr[(i * N) + j] = (i * N) + j;
    }
  }
}

void print_matrix(int *arr) {
  for (int i = 0 ; i < N ; i++) {
    for (int j = 0 ; j < N ; j++) {
      printf("%d\t", arr[(i * N) + j]);
    }
    printf("\n");
  }
  printf("\n");
}

int main() {
  int *a, *b, *c;
  int *d_a, *d_b, *d_c;
  int size = sizeof(int) * N * N;

  // Allocate memory on host.
  a = (int*) malloc(size);
  b = (int*) malloc(size);
  c = (int*) malloc(size);

  // Allocate memory on device.
  cudaMalloc((void**)&d_a, size);
  cudaMalloc((void**)&d_b, size);
  cudaMalloc((void**)&d_c, size);

  // Initialize array.
  fill_matrix(a);
  fill_matrix(b);

  // Copy from host to device.
  cudaMemcpy(d_a, a, size, cudaMemcpyHostToDevice);
  cudaMemcpy(d_b, b, size, cudaMemcpyHostToDevice);

  // Perform sum on device.
  gpuSum<<<N*N/THREADS_PER_BLOCK, THREADS_PER_BLOCK>>>(d_a, d_b, d_c, N*N);

  // Retrieve values from device to host.
  cudaMemcpy(c, d_c, size, cudaMemcpyDeviceToHost);

  // Print results.
  print_matrix(a);
  print_matrix(b);
  print_matrix(c);

  // Free host variables.
  free(a);
  free(b);
  free(c);

  // Free device variables.
  cudaFree(d_a);
  cudaFree(d_b);
  cudaFree(d_c);

  return 0;
}
