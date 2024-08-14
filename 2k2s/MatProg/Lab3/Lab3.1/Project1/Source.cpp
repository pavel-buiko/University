#include <iostream>
#include <iomanip>
#include <vector>
#include <algorithm>

const int INF = std::numeric_limits<int>::max();
const int K = 5; // Размерность матрицы d

namespace combi {
    struct permutation {
        std::vector<short> sset; short nn;
        permutation(short n) : nn(n), sset(n) { for (int i = 0; i < n; i++) sset[i] = i; };
        int getfirst() { return (nn-- > 0) ? 0 : -1; };
        int getnext();
    };
    int permutation::getnext()
    {
        if (nn <= 0) return -1;
        int k = nn - 1, t = k;
        while ((k-- > 0) && (sset[k] >= sset[k + 1])); // цикл пока последовательность не убывающая 
        if (k < 0) { nn = 0; return -1; }
        while ((t > k) && (sset[k] >= sset[t])) t--; // ищем наибольший sset[t] > sset[k] 
        std::swap(sset[k], sset[t]); // меняем их местами 
        for (int i = k + 1, j = nn - 1; i < j; i++, j--) std::swap(sset[i], sset[j]); // располагаем оставшуюся часть последовательности в возрастающем порядке 
        return 0;
    };
}

int sum(int x1, int x2) {
    return (x1 == INF || x2 == INF) ? INF : (x1 + x2);
}

int* firstpath(int n) {
    int* rc = new int[n + 1]; rc[n] = 0;
    for (int i = 0; i < n; i++) rc[i] = i;
    return rc;
}

int* source(int n) {
    int* rc = new int[n - 1];
    for (int i = 1; i < n; i++) rc[i - 1] = i;
    return rc;
}

void  copypath(int n, int* r1, const int* r2) {
    for (int i = 0; i < n; i++)  r1[i] = r2[i];
}

int distance(int n, int* r, const int* d) {
    int rc = 0;
    for (int i = 0; i < n - 1; i++) rc = sum(rc, d[r[i] * n + r[i + 1]]);
    return  sum(rc, d[r[n - 1] * n + 0]);    //+ последняя дуга (n-1,0) 
}

void indx(int n, int* r, const int* s, const std::vector<short>& ntx) {
    for (int i = 1; i < n; i++)  r[i] = s[ntx[i - 1]];
}

int salesman(int n, const int* d, int* r) {
    int* s = source(n), * b = firstpath(n), rc = INF, dist = 0;
    combi::permutation p(n - 1);
    int k = p.getfirst();
    while (k >= 0) {  // цикл генерации перестановок
        indx(n, b, s, p.sset);        // новый маршрут 
        if ((dist = distance(n, b, d)) < rc) {
            rc = dist; copypath(n, r, b);
        }
        k = p.getnext();
    }
    return rc;
}

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

int main() {
    setlocale(LC_CTYPE, "rus");
    int d[K][K] = { {INF, 4, 23, INF, 2},
                    {2, INF, 17, 66, 82},
                    {4, 6, INF, 86, 51},
                    {19, 56, 8, INF, 6},
                    {91, 68, 52, 15, INF} };

    int r[K]; // Результат
    int s1 = salesman(K, (int*)d, r);
    
    std::cout << "-- Генератор Перестановок --" << std::endl;
    std::cout << "-- Задача коммивояжера --" << std::endl;
    std::cout << "-- Количество городов: " << K << std::endl;
    std::cout << "-- Матрица расстояний: " << std::endl;
    for (int i = 0; i < K; i++) {
        for (int j = 0; j < K; j++)
            if (d[i][j] != INF)
                std::cout << std::setw(3) << d[i][j] << " ";
            else
                std::cout << std::setw(3) << "INF" << " ";
        std::cout << std::endl;
    }
    std::cout << "-- Оптимальный маршрут: ";
    for (int i = 0; i < K; i++) std::cout << r[i] << "-->";
    std::cout << "0" << std::endl;
    std::cout << "-- Длина маршрута: " << s1 << std::endl;

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

    return 0;
}
