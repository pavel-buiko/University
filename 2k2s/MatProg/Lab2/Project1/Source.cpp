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
	int V = 300, v[NN], c[NN];         // вместимость рюкзака 
	for (int i = 0; i < NN; ++i) {
		v[i] = rand() % 291 + 10; // размер предмета каждого типа  
		c[i] = rand() % 56 + 5; // стоимость предмета каждого типа 
	}
	short m[NN];                // количество предметов каждого типа  {0,1}   

	int maxcc = knapsack_s(

		V,   // [in]  вместимость рюкзака 
		NN,  // [in]  количество типов предметов 
		v,   // [in]  размер предмета каждого типа  
		c,   // [in]  стоимость предмета каждого типа     
		m    // [out] количество предметов каждого типа  
	);

	std::cout << std::endl << "-------- Задача о рюкзаке --------- ";
	std::cout << std::endl << "- количество предметов : " << NN;
	std::cout << std::endl << "- вместимость рюкзака  : " << V;
	std::cout << std::endl << "- размеры предметов    : ";
	for (int i = 0; i < NN; i++) std::cout << v[i] << " ";
	std::cout << std::endl << "- стоимости предметов  : ";
	for (int i = 0; i < NN; i++) std::cout <<  c[i] << " ";
	std::cout << std::endl << "- оптимальная стоимость рюкзака: " << maxcc;
	std::cout << std::endl << "- вес рюкзака: ";
	int s = 0; for (int i = 0; i < NN; i++) s += m[i] * v[i];
	std::cout << s;
	std::cout << std::endl << "- выбраны предметы: ";
	for (int i = 0; i < NN; i++) std::cout << " " << m[i];
	std::cout << std::endl << std::endl;
	t2 = clock();
	std::cout << std::endl << "продолжительность (у.е):   " << (t2 - t1);
	std::cout << std::endl << "                  (сек):   "
		<< ((double)(t2 - t1)) / ((double)CLOCKS_PER_SEC);
	std::cout << std::endl;


	return 0;

}
