#include <iostream>
#include "Combi.h"
#include "Knapsack.h"
#include <time.h>
#include <iomanip> 
#include <cstdlib>
#include <ctime> 
#define NN 20

int main()
{

	clock_t  t1 = 0, t2 = 0;
	setlocale(LC_ALL, "rus");
	srand(time(0));

	t1 = clock();
	int V = 300, v[NN], c[NN];         // ����������� ������� 
	for (int i = 0; i < NN; ++i) {
		v[i] = rand() % 291 + 10; // ������ �������� ������� ����  
		c[i] = rand() % 56 + 5; // ��������� �������� ������� ���� 
	}
	short m[NN];                // ���������� ��������� ������� ����  {0,1}   

	int maxcc = knapsack_s(

		V,   // [in]  ����������� ������� 
		NN,  // [in]  ���������� ����� ��������� 
		v,   // [in]  ������ �������� ������� ����  
		c,   // [in]  ��������� �������� ������� ����     
		m    // [out] ���������� ��������� ������� ����  
	);

	std::cout << std::endl << "-------- ������ � ������� --------- ";
	std::cout << std::endl << "- ���������� ��������� : " << NN;
	std::cout << std::endl << "- ����������� �������  : " << V;
	std::cout << std::endl << "- ������� ���������    : ";
	for (int i = 0; i < NN; i++) std::cout << v[i] << " ";
	std::cout << std::endl << "- ��������� ���������  : ";
	for (int i = 0; i < NN; i++) std::cout <<  c[i] << " ";
	std::cout << std::endl << "- ����������� ��������� �������: " << maxcc;
	std::cout << std::endl << "- ��� �������: ";
	int s = 0; for (int i = 0; i < NN; i++) s += m[i] * v[i];
	std::cout << s;
	std::cout << std::endl << "- ������� ��������: ";
	for (int i = 0; i < NN; i++) std::cout << " " << m[i];
	std::cout << std::endl << std::endl;
	t2 = clock();
	std::cout << std::endl << "����������������� (�.�):   " << (t2 - t1);
	std::cout << std::endl << "                  (���):   "
		<< ((double)(t2 - t1)) / ((double)CLOCKS_PER_SEC);
	std::cout << std::endl;


	return 0;

}
