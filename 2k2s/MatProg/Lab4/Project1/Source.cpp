#include <iostream>
#include <string>
#include <cstdlib>
#include <ctime>
#include <vector>
#include <chrono>

using namespace std;
// Функция для генерации случайной строки заданной длины
string generateRandomString(int length) {
	static const char alphanum[] =
		"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
		"abcdefghijklmnopqrstuvwxyz";

	string randomString;
	randomString.reserve(length);

	for (int i = 0; i < length; ++i) {
		randomString += alphanum[rand() % (sizeof(alphanum) - 1)];
	}

	return randomString;
}

int min(int x, int y, int z) {
	return min(min(x, y), z);
}

// Функция для вычисления расстояния Левенштейна с использованием динамического программирования
int levenshteinDistanceDP(const string& str1, const string& str2, int len1, int len2) {
	// Создаем таблицу для хранения промежуточных результатов
	vector<vector<int>> dp(len1 + 1, vector<int>(len2 + 1, 0));

	// Заполняем базовые случаи
	for (int i = 0; i <= len1; ++i) {
		for (int j = 0; j <= len2; ++j) {
			if (i == 0) {
				dp[i][j] = j;
			}
			else if (j == 0) {
				dp[i][j] = i;
			}
			else if (str1[i - 1] == str2[j - 1]) {
				dp[i][j] = dp[i - 1][j - 1];
			}
			else {
				dp[i][j] = 1 + min(dp[i][j - 1],       // Вставка
					dp[i - 1][j],       // Удаление
					dp[i - 1][j - 1]); // Замена
			}
		}
	}

	// Возвращаем значение в правом нижнем углу таблицы
	return dp[len1][len2];
}


// Функция для вычисления расстояния Левенштейна рекурсивным методом
int levenshteinDistanceRecursive(const string& str1, int len1, const string& str2, int len2) {
	// Базовые случаи
	if (len1 == 0) return len2;
	if (len2 == 0) return len1;

	// Если последние символы совпадают
	if (str1[len1 - 1] == str2[len2 - 1]) {
		return levenshteinDistanceRecursive(str1, len1 - 1, str2, len2 - 1);
	}

	// Иначе, вычисляем минимальное из трех возможных случаев и добавляем 1
	return 1 + min(
		levenshteinDistanceRecursive(str1, len1, str2, len2 - 1),   // Вставка
		levenshteinDistanceRecursive(str1, len1 - 1, str2, len2),   // Удаление
		levenshteinDistanceRecursive(str1, len1 - 1, str2, len2 - 1) // Замена
	);
}

int main() {
	setlocale(LC_CTYPE, "Russian");
	// Инициализация генератора случайных чисел
	srand(time(0));

	// Генерация строк
	string S1 = generateRandomString(300);
	string S2 = generateRandomString(200);

	// Вывод строк
	cout << "Случайная строка S1 (длина 300): " << S1 << endl;
	cout << "Случайная строка S2 (длина 200): " << S2 << endl;


	double k = 1.0 / 25.0;

	auto startRecursive = std::chrono::high_resolution_clock::now();
	int distance = levenshteinDistanceRecursive(S1, S1.length() * k, S2, S2.length() * k);
	auto endRecursive = std::chrono::high_resolution_clock::now();
	std::chrono::duration<double> elapsedRecursive = endRecursive - startRecursive;
	std::cout << "-----------------------------------Рекурсивный метод-----------------------------------------" << std::endl;
	std::cout << "Расстояние Левенштейна между строками: " << distance << std::endl;
	std::cout << "Время выполнения (рекурсивный метод): " << elapsedRecursive.count() << " сек" << std::endl;

	auto startDP = std::chrono::high_resolution_clock::now();
	int distanceDyn = levenshteinDistanceDP(S1, S2, S1.length() * k, S2.length() * k);
	auto endDP = std::chrono::high_resolution_clock::now();
	std::chrono::duration<double> elapsedDP = endDP - startDP;
	std::cout << "-----------------------------------Динамическое программирование-----------------------------------------" << std::endl;
	std::cout << "Расстояние Левенштейна между строками: " << distanceDyn << std::endl;
	std::cout << "Время выполнения (динамическое программирование): " << elapsedDP.count() << " сек" << std::endl;

	return 0;
}