#include <iostream>
#include <iomanip> 
#include "ReplacementCombi.h"

#define N 5
#define INF 99999
int main() {
    int d[N][N] = {
        {0, 45, INF, 25, 50},
        {45, 0, 55, 20, 100},
        {70, 20, 0, 10, 30},
        {80, 10, 40, 0, 10},
        {30, 50, 20, 10, 0}
    };

    int r[N]; // результат
    int salesmanResult = salesman(N, (int*)d, r);

    // Вывод результатов, полученных методом перебора всех вариантов маршрутов
    std::cout << "-- Оптимальный маршрут (перебор) --" << std::endl;
    std::cout << "Маршрут: ";
    for (int i = 0; i < N; ++i)
        std::cout << r[i] << "-->";
    std::cout << "0" << std::endl;
    std::cout << "Длина маршрута: " << salesmanResult << std::endl;

    // Решение с помощью метода ветвей и границ
    int branchBoundResult = tspBranchAndBound();

    // Сравнение результатов
    std::cout << "-- Сравнение результатов --" << std::endl;
    if (salesmanResult == branchBoundResult) {
        std::cout << "Результаты совпадают: " << salesmanResult << std::endl;
    }
    else {
        std::cout << "Результаты не совпадают!" << std::endl;
        std::cout << "Метод перебора: " << salesmanResult << std::endl;
        std::cout << "Метод ветвей и границ: " << branchBoundResult << std::endl;
    }

    return 0;
}
