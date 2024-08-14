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

    int r[N]; // ���������
    int salesmanResult = salesman(N, (int*)d, r);

    // ����� �����������, ���������� ������� �������� ���� ��������� ���������
    std::cout << "-- ����������� ������� (�������) --" << std::endl;
    std::cout << "�������: ";
    for (int i = 0; i < N; ++i)
        std::cout << r[i] << "-->";
    std::cout << "0" << std::endl;
    std::cout << "����� ��������: " << salesmanResult << std::endl;

    // ������� � ������� ������ ������ � ������
    int branchBoundResult = tspBranchAndBound();

    // ��������� �����������
    std::cout << "-- ��������� ����������� --" << std::endl;
    if (salesmanResult == branchBoundResult) {
        std::cout << "���������� ���������: " << salesmanResult << std::endl;
    }
    else {
        std::cout << "���������� �� ���������!" << std::endl;
        std::cout << "����� ��������: " << salesmanResult << std::endl;
        std::cout << "����� ������ � ������: " << branchBoundResult << std::endl;
    }

    return 0;
}
