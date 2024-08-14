#include <iostream>
#include <chrono>
#include <cstring> // для использования memset
#include "MultyMatrix.h" // умножение матриц
#define N 6

int main()
{
    setlocale(LC_CTYPE, "Rus");
    int Mc[N + 1] = { 7, 10, 18, 21, 28, 38, 49 };
    int Ms[N][N] = { 0 };
    int r = 0, rd = 0;

    // Рекурсивное решение
    auto startRecursive = std::chrono::high_resolution_clock::now();
    r = OptimalM(1, N, N, Mc, (int*)Ms);
    auto endRecursive = std::chrono::high_resolution_clock::now();
    std::chrono::duration<double> elapsedRecursive = endRecursive - startRecursive;

    std::cout << std::endl;
    std::cout << std::endl << "----------расстановка скобок (рекурсивное решение)---------------------" << std::endl;
    std::cout << "размерности матриц: ";
    for (int i = 1; i <= N; i++) std::cout << "(" << Mc[i - 1] << "," << Mc[i] << ") ";
    std::cout << std::endl << "минимальное количество операций умножения: " << r;
    std::cout << std::endl << "Время выполнения (рекурсивное решение): " << elapsedRecursive.count() << " сек" << std::endl;

    std::cout << std::endl << "матрица S" << std::endl;
    for (int i = 0; i < N; i++)
    {
        std::cout << std::endl;
        for (int j = 0; j < N; j++)  std::cout << Ms[i][j] << "  ";
    }
    std::cout << std::endl;

    // Динамическое программирование
    memset(Ms, 0, sizeof(int) * N * N);
    auto startDP = std::chrono::high_resolution_clock::now();
    rd = OptimalMD(N, Mc, (int*)Ms);
    auto endDP = std::chrono::high_resolution_clock::now();
    std::chrono::duration<double> elapsedDP = endDP - startDP;

    std::cout << std::endl << "----------расстановка скобок (динамическое программирование)---------------------" << std::endl;
    std::cout << "размерности матриц: ";
    for (int i = 1; i <= N; i++)
        std::cout << "(" << Mc[i - 1] << "," << Mc[i] << ") ";
    std::cout << std::endl << "минимальное количество операций умножения: " << rd;
    std::cout << std::endl << "Время выполнения (динамическое программирование): " << elapsedDP.count() << " сек" << std::endl;

    std::cout << std::endl << "матрица S" << std::endl;
    for (int i = 0; i < N; i++)
    {
        std::cout << std::endl;
        for (int j = 0; j < N; j++)  std::cout << Ms[i][j] << "  ";
    }
    std::cout << std::endl << std::endl;

    return 0;
}
