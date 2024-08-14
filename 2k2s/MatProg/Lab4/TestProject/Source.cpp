#include <iostream>
#include <vector>
#include <chrono>

using namespace std;
using namespace chrono;

// Рекурсивная функция для нахождения минимального количества умножений
int minMultiplications(const vector<int>& dimensions, int i, int j) {
    if (i == j)
        return 0;

    int minOps = INT_MAX;

    for (int k = i; k < j; ++k) {
        int ops = minMultiplications(dimensions, i, k) +
            minMultiplications(dimensions, k + 1, j) +
            dimensions[i - 1] * dimensions[k] * dimensions[j];
        minOps = min(minOps, ops);
    }

    return minOps;
}

int main() {
    setlocale(LC_CTYPE, "Rus");
    vector<int> dimensions = { 7, 10, 18, 21, 28, 38, 49 };

    auto start = high_resolution_clock::now();
    int minOps = minMultiplications(dimensions, 1, dimensions.size() - 1);
    auto stop = high_resolution_clock::now();

    auto duration = duration_cast<microseconds>(stop - start);
    cout << "Минимальное количество умножений (рекурсия): " << minOps << endl;
    cout << "Время выполнения (рекурсия): " << duration.count() << " микросекунд" << endl;

    return 0;
}
