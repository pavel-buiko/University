#include <iostream>
#include <string>
#include <cstdlib>
#include <ctime>
#include <vector>
#include <chrono>

using namespace std;
// ������� ��� ��������� ��������� ������ �������� �����
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

// ������� ��� ���������� ���������� ����������� � �������������� ������������� ����������������
int levenshteinDistanceDP(const string& str1, const string& str2, int len1, int len2) {
	// ������� ������� ��� �������� ������������� �����������
	vector<vector<int>> dp(len1 + 1, vector<int>(len2 + 1, 0));

	// ��������� ������� ������
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
				dp[i][j] = 1 + min(dp[i][j - 1],       // �������
					dp[i - 1][j],       // ��������
					dp[i - 1][j - 1]); // ������
			}
		}
	}

	// ���������� �������� � ������ ������ ���� �������
	return dp[len1][len2];
}


// ������� ��� ���������� ���������� ����������� ����������� �������
int levenshteinDistanceRecursive(const string& str1, int len1, const string& str2, int len2) {
	// ������� ������
	if (len1 == 0) return len2;
	if (len2 == 0) return len1;

	// ���� ��������� ������� ���������
	if (str1[len1 - 1] == str2[len2 - 1]) {
		return levenshteinDistanceRecursive(str1, len1 - 1, str2, len2 - 1);
	}

	// �����, ��������� ����������� �� ���� ��������� ������� � ��������� 1
	return 1 + min(
		levenshteinDistanceRecursive(str1, len1, str2, len2 - 1),   // �������
		levenshteinDistanceRecursive(str1, len1 - 1, str2, len2),   // ��������
		levenshteinDistanceRecursive(str1, len1 - 1, str2, len2 - 1) // ������
	);
}

int main() {
	setlocale(LC_CTYPE, "Russian");
	// ������������� ���������� ��������� �����
	srand(time(0));

	// ��������� �����
	string S1 = generateRandomString(300);
	string S2 = generateRandomString(200);

	// ����� �����
	cout << "��������� ������ S1 (����� 300): " << S1 << endl;
	cout << "��������� ������ S2 (����� 200): " << S2 << endl;


	double k = 1.0 / 25.0;

	auto startRecursive = std::chrono::high_resolution_clock::now();
	int distance = levenshteinDistanceRecursive(S1, S1.length() * k, S2, S2.length() * k);
	auto endRecursive = std::chrono::high_resolution_clock::now();
	std::chrono::duration<double> elapsedRecursive = endRecursive - startRecursive;
	std::cout << "-----------------------------------����������� �����-----------------------------------------" << std::endl;
	std::cout << "���������� ����������� ����� ��������: " << distance << std::endl;
	std::cout << "����� ���������� (����������� �����): " << elapsedRecursive.count() << " ���" << std::endl;

	auto startDP = std::chrono::high_resolution_clock::now();
	int distanceDyn = levenshteinDistanceDP(S1, S2, S1.length() * k, S2.length() * k);
	auto endDP = std::chrono::high_resolution_clock::now();
	std::chrono::duration<double> elapsedDP = endDP - startDP;
	std::cout << "-----------------------------------������������ ����������������-----------------------------------------" << std::endl;
	std::cout << "���������� ����������� ����� ��������: " << distanceDyn << std::endl;
	std::cout << "����� ���������� (������������ ����������������): " << elapsedDP.count() << " ���" << std::endl;

	return 0;
}