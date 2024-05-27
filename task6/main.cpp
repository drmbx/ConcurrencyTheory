#include <iostream>
#include <vector>
#include <cmath>
#include <boost/program_options.hpp>

void InitializeGrid(std::vector<double> &grid, size_t n, double val0, double val1, double val2, double val3) {
    auto Interpolation = [](size_t x, size_t x0, size_t x1, double f_x0, double f_x1) {
        return f_x0 + ((f_x1 - f_x0) / static_cast<double>(x1 - x0)) * static_cast<double>(x - x0);
    };
    // Corner values initialization
    grid[0] = val0;              // 0----1
    grid[n - 1] = val1;          // |    |
    grid[n * n - 1] = val2;      // |    |
    grid[n * (n - 1)] = val3;    // 3----2
    // Linear interpolation
    for (size_t i = 1; i < n - 1; ++i) {
        grid[i] = Interpolation(i, 0, n - 1, grid[0], grid[n - 1]); // 0-1
        grid[i * n + n - 1] = Interpolation(i, 0, n - 1, grid[n - 1], grid[n * n - 1]); // 1-2
        grid[n * (n - 1) + i] = Interpolation(i, 0, n - 1, grid[n * (n - 1)], grid[n * n - 1]); // 3-2
        grid[i * n] = Interpolation(i, 0, n - 1, grid[0], grid[n * (n - 1)]); // 0-3
    }
}

double CalculateNext(const std::vector<double> &grid, std::vector<double> &new_grid, size_t n) {
    double error{};
#pragma acc parallel loop reduction(max:error)
    for (size_t y = 1; y < n - 1; ++y) {
#pragma acc loop
        for (size_t x = 1; x < n - 1; ++x) {
            new_grid[y * n + x] = 0.2 * (grid[y * n + x]
                                         + grid[y * (n - 1) + x]
                                         + grid[y * n + x + 1]
                                         + grid[y * (n + 1) + x]
                                         + grid[y * n + x - 1]);
            error = fmax(error, fabs(grid[y * n + x] - new_grid[y * n + x]));
        }
    }
    return error;
}

void PrintMatrix(const std::vector<double> &matrix, size_t n) {
    for (size_t y = 0; y < n; ++y) {
        for (size_t x = 0; x < n; ++x) {
            std::cout << matrix[y * n + x] << " ";
        }
        std::cout << std::endl;
    }
}

int main(int argc, char **argv) {
    double epsilon = std::stod(argv[1]);
    size_t n = atoi(argv[2]);
    size_t n_max_iterations = atoi(argv[3]);

    std::vector<double> grid(n * n, 0);
    std::vector<double> new_grid(n * n, 0);
    InitializeGrid(grid, n, 10, 20, 30, 20);
    InitializeGrid(new_grid, n, 10, 20, 30, 20);

    size_t last_step{};
    double error = 1;
    for (size_t i{}; i < n_max_iterations && error > epsilon; ++i) {
        error = CalculateNext(grid, new_grid, n);
        std::swap(grid, new_grid);
        last_step = i;
    }
    PrintMatrix(grid, n);
    std::cout << last_step << std::endl;
}
