/*
*
*    Carlos Roman Rivera - A01700820
*
*    Programming Languages - Cuda Lab 2
*
*/

#include <stdio.h>
#include <stdlib.h>
#include <cuda.h>
#include <time.h>

__global__ void matrix_multiplication(int *matrix_1, int *matrix_2, int *matrix_r, int m, int n, int p){

	int row = threadIdx.y + blockIdx.y * blockDim.y; 	// Multiply this row...
	int col = threadIdx.x + blockIdx.x * blockDim.x;	// with this column.

	// Matrix multiplication as follows:
	// (m x n) x (n x p) = (m x p)

	int id = row * p + col;	// Index of the result matrix in which we will write.
	int sum = 0;

	if (row < m && col < p) {
		for(int i = 0; i < n; i++) {
			// In matrix_1 we keep the row and advance in the columns.
			// In matrix_2 we keep the column and advance in the rows.
			sum = sum + matrix_1[row * n + i] * matrix_2[i * p + col];
			// row * n stays in the same row and  "+ i" advances 1 column each cicle.
			// i * p advances one row each cicle and  "+ col" keeps the same col.
		}
	 	matrix_r[id] = sum;
	}
}


// Display a matrix of the given dimensions.
void print_matrix(int *mat, int rows, int cols){
	for (int i = 0; i < rows; i++){
		for (int j = 0; j < cols; j++){
			printf("%d\t", mat[i * cols + j]);
		}
		printf("\n");
	}
	printf("\n");
}

// User gives the value of each element of the matrix.
void user_matrix(int *mat, int rows, int cols){
	int aux;
	for (int i = 0; i < rows; i++){
		for (int j = 0; j < cols; j++){
			printf("[%d][%d] = ", i, j);
			scanf("%i%*c", &aux);
			mat[i * cols + j] = aux;
		}
	}
}

// "Randomly" generate the value of each element of the matrix.
void fill_matrix(int *mat, int rows, int cols){
	for (int i = 0; i < rows; i++){
		for (int j = 0; j < cols; j++){
			mat[i * cols + j] = (rand() % 99) + 1;
		}
	}
}

int main(){

  srand(time(0));

	// Matrices
  int *h_matrix_1, *h_matrix_2, *h_matrix_r;
  int *d_matrix_1, *d_matrix_2, *d_matrix_r;

	// Dimensions
  int matrix_1_rows, matrix_1_cols;
  int matrix_2_rows, matrix_2_cols;

	// Memory size
  int matrix_1_size, matrix_2_size, matrix_r_size;

	// User input for whether randomly or manually initialize matrices.
	int respuesta;

  printf("Matrix 1 rows: ");
  scanf("%d%*c", &matrix_1_rows);

  printf("Matrix 1 cols: ");
  scanf("%d%*c", &matrix_1_cols);

  printf("\nMatrix 2 rows: ");
  scanf("%d%*c", &matrix_2_rows);

  printf("Matrix 2 cols: ");
  scanf("%d%*c", &matrix_2_cols);

	// Matrices must be (m x n) and (n x p)
	if (matrix_1_cols != matrix_2_rows) {
		printf("\nLas dimensiones introducidas no son aceptables.\n");
		return 0;
	}

	// Calculate memory given dimensions.
  matrix_1_size = sizeof(int) * matrix_1_rows * matrix_1_cols;
  matrix_2_size = sizeof(int) * matrix_2_rows * matrix_2_cols;
  matrix_r_size = sizeof(int) * matrix_1_rows * matrix_2_cols;

	// Allocate memory.
  h_matrix_1 = (int *)malloc(matrix_1_size);
  h_matrix_2 = (int *)malloc(matrix_2_size);
  h_matrix_r = (int *)malloc(matrix_r_size);


	// Select how to initialize matrices.
	printf("\nDeseas:\n1. Introducir matrices manualmente.\n2. Generar matrices aleatoriamente.\nR = ");

	scanf("%d%*c", &respuesta);

	if(respuesta == 1) {
		// User wants to initialize matrix.
		printf("\nMatriz A: \n");
		user_matrix(h_matrix_1, matrix_1_rows, matrix_1_cols);

		printf("\nMatriz B: \n");
		user_matrix(h_matrix_2, matrix_2_rows, matrix_2_cols);
	} else {
		// User wants random initialization.
		if (respuesta != 2) {
			// Invalid answer, therefore, randomly initialized.
			printf("\nOpcion invalida, generando aleatorias.\n");
		}
		fill_matrix(h_matrix_1, matrix_1_rows, matrix_1_cols);
	  fill_matrix(h_matrix_2, matrix_2_rows, matrix_2_cols);
	}

	// Display matrix for interactive purpose.
	printf("\nMatrix A:\n");
  print_matrix(h_matrix_1, matrix_1_rows, matrix_1_cols);

	// Display matrix for interactive purpose.
	printf("Matrix B:\n");
  print_matrix(h_matrix_2, matrix_2_rows, matrix_2_cols);

	// Allocate memory on device.
  cudaMalloc((void**)&d_matrix_1, matrix_1_size);
  cudaMalloc((void**)&d_matrix_2, matrix_2_size);
  cudaMalloc((void**)&d_matrix_r, matrix_r_size);

	// Copy initialized matrices from host to device.
  cudaMemcpy(d_matrix_1, h_matrix_1, matrix_1_size, cudaMemcpyHostToDevice);
  cudaMemcpy(d_matrix_2, h_matrix_2, matrix_2_size, cudaMemcpyHostToDevice);

	// Each thread will calculate each element of the result matrix.
  int ThreadsPerBlock = matrix_2_cols;
  int NumBlocks = matrix_1_rows;

  dim3 Blocks(NumBlocks, NumBlocks);
  dim3 Threads(ThreadsPerBlock, ThreadsPerBlock);

	// Display for interactive purpose.
	printf("Blocks: %d\n", NumBlocks);
	printf("Threads/Block: %d\n", ThreadsPerBlock);

	// Execute on device.
  matrix_multiplication<<<Blocks, Threads>>>(d_matrix_1, d_matrix_2, d_matrix_r, matrix_1_rows, matrix_1_cols, matrix_2_cols);

	// Retrieve result from device and copy to host.
  cudaMemcpy(h_matrix_r, d_matrix_r, matrix_r_size, cudaMemcpyDeviceToHost);

	// Display results for illustrative purposes.
	printf("\n");
	printf("Matrix R:\n");
  print_matrix(h_matrix_r, matrix_1_rows, matrix_2_cols);

	// Free host memory.
  free(h_matrix_1);
  free(h_matrix_2);
  free(h_matrix_r);

	// Free device memory.
  cudaFree(d_matrix_1);
  cudaFree(d_matrix_2);
  cudaFree(d_matrix_r);

}
