#include "pch.h"
#include "factorial.h";

long double factorial(int number) {
	if (number == 1) {
		return 1;
	}
	return number * factorial(number - 1);
}