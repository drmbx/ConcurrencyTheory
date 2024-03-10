#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <omp.h>

void matrix_vector_product(const double *a, const double *b, double *c, int m, int n) {
    for (int i = 0; i < m; i++) {
        c[i] = 0.0;
        for (int j = 0; j < n; j++)
            c[i] += a[i * n + j] * b[j];
    }
}

void matrix_vector_product_omp(const double *a, const double *b, double *c, int m, int n, int threads) {
#pragma omp parallel num_threads(threads)
    {
        int nThreads = omp_get_num_threads();
        int threadId = omp_get_thread_num();
        int items_per_thread = m / nThreads;
        int lb = threadId * items_per_thread;
        int ub = (threadId == nThreads - 1) ? (m - 1) : (lb + items_per_thread - 1);
        for (int i = lb; i <= ub; i++) {
            c[i] = 0.0;
            for (int j = 0; j < n; j++)
                c[i] += a[i * n + j] * b[j];
        }
    }
}

void run_serial(int m, int n, int iterations) {
    double *a, *b, *c;
    a = (double *) malloc(sizeof(*a) * m * n);
    b = (double *) malloc(sizeof(*b) * n);
    c = (double *) malloc(sizeof(*c) * m);
    for (int i = 0; i < m; i++)
        for (int j = 0; j < n; j++)
            a[i * n + j] = i + j;
    for (int j = 0; j < n; j++)
        b[j] = j;
    double t = omp_get_wtime();
    for (int i = 0; i < iterations; i++)
        matrix_vector_product(a, b, c, m, n);
    t = omp_get_wtime() - t;
    printf("Elapsed time (serial): %.6f sec.\n", t / iterations);
    free(a);
    free(b);
    free(c);
}

void run_parallel(int m, int n, int threads, int iterations) {
    double *a, *b, *c;
// Allocate memory for 2-d array a[m, n]
    a = (double *) malloc(sizeof(*a) * m * n);
    b = (double *) malloc(sizeof(*b) * n);
    c = (double *) malloc(sizeof(*c) * m);
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++)
            a[i * n + j] = i + j;
    }
    for (int j = 0; j < n; j++)
        b[j] = j;
    double t = omp_get_wtime();
    for (int i = 0; i < iterations; i++)
        matrix_vector_product_omp(a, b, c, m, n, threads);
    t = omp_get_wtime() - t;
    printf("Elapsed time (parallel): %.6f sec.\n", t / iterations);
    free(a);
    free(b);
    free(c);
}

int main(int argc, char **argv) {
    if (argc != 5)
        return 1;
    int m = atoi(argv[1]);
    int n = atoi(argv[2]);
    int threads = atoi(argv[3]);
    int iterations = atoi(argv[4]);
    printf("Matrix-vector product (c[m] = a[m, n] * b[n]; m = %d, n = %d)\n", m, n);
    printf("Memory used: %lu MiB\n", ((m * n + m + n) * sizeof(double)) >> 20);

    run_serial(m, n, iterations);
    run_parallel(m, n, threads, iterations);

    return 0;
}
