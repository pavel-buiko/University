#include <iostream>
#include <iomanip> 
#include "Combi.h"
#include "Salesman.h"
#include <vector>
#define K 5
#define N (sizeof(AA)/2)
#define M 3
// Метод ветвей и границ
class BranchAndBoundTSP {
private:
	int n;
	const int* d;
	int* r;
	std::vector<int> best_path;
	int best_distance;

	void branch(int level, int bound) {
		if (level == n - 1) {
			int current_distance = bound + d[r[level - 1] * n + r[level]] + d[r[level] * n + 0];
			if (current_distance < best_distance) {
				best_distance = current_distance;
				best_path.assign(r, r + n);
			}
		}
		else {
			for (int i = level; i < n; ++i) {
				std::swap(r[level], r[i]);
				int new_bound = bound + d[r[level - 1] * n + r[level]];
				if (new_bound < best_distance) {
					branch(level + 1, new_bound);
				}
				std::swap(r[level], r[i]);
			}
		}
	}

public:
	BranchAndBoundTSP(int cities, const int* distances, int* route) : n(cities), d(distances), r(route), best_distance(INF) {}

	void solve() {
		r[0] = 0;
		for (int i = 1; i < n; ++i) r[i] = i;
		branch(1, 0);
	}

	std::vector<int> getBestPath() const {
		return best_path;
	}

	int getBestDistance() const {
		return best_distance;
	}
};

int main()
{
	setlocale(LC_ALL, "rus");
	char  AA[][2] = { "A", "B", "C", "D" };
	std::cout << std::endl << " --- Генератор размещений ---";
	std::cout << std::endl << "Исходное множество: ";
	std::cout << "{ ";
	for (int i = 0; i < N; i++)

		std::cout << AA[i] << ((i < N - 1) ? ", " : " ");
	std::cout << "}";
	std::cout << std::endl << "Генерация размещений  из  " << N << " по " << M;
	combi::accomodation s(N, M);
	int  n = s.getfirst();
	while (n >= 0)
	{

		std::cout << std::endl << std::setw(2) << s.na << ": { ";

		for (int i = 0; i < 3; i++)

			std::cout << AA[s.ntx(i)] << ((i < n - 1) ? ", " : " ");

		std::cout << "}";

		n = s.getnext();
	};
	std::cout << std::endl << "всего: " << s.count() << std::endl;

	std::cout << "-------------------------------------------------" << std::endl;


	int d[K][K] = { //0   1    2    3     4        
			   {INF, 4, 23, INF, 2},
				{2, INF, 17, 66, 82},
				{4, 6, INF, 86, 51},
				{19, 56, 8, INF, 6},
				{91, 68, 52, 15, INF}
	};
	int r[K];                     // результат 
	int s1 = salesman(
		K,          // [in]  количество городов 
		(int*)d,          // [in]  массив [n*n] расстояний 
		r           // [out] массив [n] маршрут 0 x x x x  

	);
	std::cout << std::endl << "-- Задача коммивояжера -- ";
	std::cout << std::endl << "-- количество  городов: " << K;
	std::cout << std::endl << "-- матрица расстояний : ";
	for (int i = 0; i < K; i++)
	{
		std::cout << std::endl;
		for (int j = 0; j < K; j++)

			if (d[i][j] != INF) std::cout << std::setw(3) << d[i][j] << " ";

			else std::cout << std::setw(3) << "INF" << " ";
	}
	std::cout << std::endl << "-- оптимальный маршрут: ";
	for (int i = 0; i < K; i++) std::cout << r[i] << "-->"; std::cout << 0;
	std::cout << "-- длина маршрута     : ";
	std::cout << s1;
	std::cout << std::endl;
	system("pause");


	// Метод ветвей и границ
	BranchAndBoundTSP bbtsp(K, (int*)d, r);
	bbtsp.solve();
	std::vector<int> best_path = bbtsp.getBestPath();
	int best_distance = bbtsp.getBestDistance();

	std::cout << std::endl;
	std::cout << "-- Метод ветвей и границ --" << std::endl;
	std::cout << "-- Оптимальный маршрут: ";
	for (int i = 0; i < K; ++i) std::cout << best_path[i] << "-->";
	std::cout << "0" << std::endl;
	std::cout << "-- Длина маршрута: " << best_distance << std::endl;
	system("pause");
	return 0;
}
