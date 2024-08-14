#include "pch.h"
#include "factorial.h"
#define  CYCLE 1000000                 // количество циклов  

int main()
{

	double  av1 = 0, av2 = 0;
	clock_t  t1 = 0, t2 = 0, t3 = 0, t4 = 0;

	setlocale(LC_ALL, "rus");

	auxil::start();                          // старт генерации 
	t1 = clock();                            // фиксаци€ времени 
	for (int i = 0; i < CYCLE; i++)
	{
		av1 += (double)auxil::iget(-100, 100); // сумма случайных чисел 
		av2 += auxil::dget(-100, 100);         // сумма случайных чисел 
	}
	t2 = clock();                            // фиксаци€ времени 


	std::cout << std::endl << "количество циклов:         " << CYCLE;
	std::cout << std::endl << "среднее значение (int):    " << av1 / CYCLE;
	std::cout << std::endl << "среднее значение (double): " << av2 / CYCLE;
	std::cout << std::endl << "продолжительность (у.е):   " << (t2 - t1);
	std::cout << std::endl << "                  (сек):   "
		<< ((double)(t2 - t1)) / ((double)CLOCKS_PER_SEC);
	std::cout << std::endl;

	t3 = clock();
	std::cout << '\n' << "–езультат:" << factorial(1);
	t4 = clock();
	std::cout << '\n' << "¬рем€ выполнени€:" << ((double)(t4 - t3)) / ((double)CLOCKS_PER_SEC);
	return 0;
}