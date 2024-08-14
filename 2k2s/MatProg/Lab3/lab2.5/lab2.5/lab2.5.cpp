#include <iostream>
#include <iomanip>
#include <cstdlib>
#include <ctime> 
#include "Salesman.h"
#define N 5
#define INF 9999

void fillRandomDistances(int d[N][N]) {
    // Инициализируем генератор случайных чисел текущим временем
    srand(time(0));
    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < N; ++j) {
            if (i == j) {
                // Расстояние от города до самого себя должно быть нулевым
                d[i][j] = 0;
            }
            else {
                d[i][j] = rand() % 291 + 10;
            }
        }
    }
    d[0][3] = d[3][0] = d[1][4] = d[4][1] = d[2][3] = d[3][2] = INF;
}

int main() {
    setlocale(LC_ALL, "rus");
    int d[N][N]; // Массив расстояний
    fillRandomDistances(d); // Заполняем массив случайными расстояниями

    int r[N]; // Результат
    int s = salesman(
        N,       // [in]  количество городов
        (int*)d, // [in]  массив [n*n] расстояний
        r        // [out] массив [n] маршрут 0 x x x x
    );

    std::cout << std::endl << "-- Задача коммивояжера -- ";
    std::cout << std::endl << "-- количество городов: " << N;
    std::cout << std::endl << "-- матрица расстояний : ";
    for (int i = 0; i < N; i++) {
        std::cout << std::endl;
        for (int j = 0; j < N; j++) {
            if (d[i][j] != INF) {
                std::cout << std::setw(3) << d[i][j] << " ";
            }
            else {
                std::cout << std::setw(3) << "INF" << " ";
            }
        }
    }

    std::cout << std::endl << "-- оптимальный маршрут: ";
    for (int i = 0; i < N; i++) {
        std::cout << r[i] << "-->";
    }
    std::cout << 0; // Возвращаемся в начальный город
    std::cout << std::endl << "-- длина маршрута     : " << s;
    std::cout << std::endl;

    system("pause");
    return 0;
}
