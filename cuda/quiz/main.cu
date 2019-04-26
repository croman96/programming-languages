/*
*
*    Carlos Roman Rivera - A01700820
*
*    Programming Languages - Cuda Quiz
*
*/

#include <stdio.h>

#define N 9
#define K N/3
#define ThreadsPerBlock K
#define NumBlocks K

__global__ void compress(float *mat, int n, float *comp, int k){
  int row = threadIdx.y + blockIdx.y * blockDim.y;
  int col = threadIdx.x + blockIdx.x * blockDim.x;

  if (row < k && col < k) {
    comp[col + row * k] = 0;
    for (int i_row = 0 ; i_row < k ; i_row++) {
      for (int j_col = 0 ; j_col < k ; j_col++) {
        comp[col + row * k] += mat[(col + j_col) + (row + i_row) * n];
      }
    }
  }

}

void print_mat(float *mat, int n){
	for (int i = 0; i < n; i++){
		for (int j = 0; j < n; j++){
			printf("%.1f\t", mat[i*n+j]);
		}
		printf("\n");
	}
	printf("\n");
}

void fill_mat(float *mat, int n){
	int c = 0;
	for (int i = 0; i < n; i++){
		for (int j = 0; j < n; j++){
			mat[i*n+j] = c++;
		}
	}
}

int main(){
	float *h_compress, *h_matrix;
	float *d_compress, *d_matrix;

	h_compress = (float *)malloc(sizeof(float) * K * K);
	h_matrix = (float *)malloc(sizeof(float) * N * N);

	fill_mat(h_matrix, N);
  fill_mat(h_compress, K);

	printf("Input matrix:\n");
	print_mat(h_matrix, N);

  cudaMemcpy(d_matrix, h_matrix, sizeof(float) * N * N, cudaMemcpyHostToDevice);
  cudaMemcpy(d_compress, h_compress, sizeof(float) * K * K, cudaMemcpyHostToDevice);

  dim3 Blocks(K,K);
	dim3 Threads(K,K);

  compress<<<Blocks, Threads>>>(d_matrix, N, d_compress, K);

  cudaMemcpy(h_compress, d_compress, sizeof(float) * K * K, cudaMemcpyDeviceToHost);

  printf("Compressed matrix:\n");
  print_mat(h_compress, K);

  free(h_matrix);
  free(h_compress);

  cudaFree(d_matrix);
  cudaFree(d_compress);

}
