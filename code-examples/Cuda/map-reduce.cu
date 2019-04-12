__global__ void dot(float *a, float *b, floar *c) {
  __shared__ float cache(THREADS_PER_BLOCK);

  int tid = threadIdx.x + blockDim.x * blockIdx.x;
  int cacheIndex = threadIdx.x;

  float temp = 0 ;

  while (tid < N) {
    temp += a[tid] * b[tid];
    tid += blockDim.x * gridDim.x;
  }

  cache[cacheIndex] = temp;

  __syncthreads();

  int i = blockDim.x / 2;

  while (i != 0) {
    if (cacheIndex < i) {
      cache[cacheIndex] += cache[cacheIndex + i];
    }
    __syncthreads();
    i /= 2;
  }

  if (cacheIndex == 0) {
    c[blockIdx.x] = cache[0];
  }
}
