#include "Combi.h"
#include <algorithm>
namespace combi
{
    xcombination::xcombination(short n, short m)
    {
        this->n = n;
        this->m = m;
        this->sset = new short[m + 2];
        this->reset();
    }
    void  xcombination::reset()     // �������� ���������, ������ ������� 
    {
        this->nc = 0;
        for (int i = 0; i < this->m; i++) this->sset[i] = i;
        this->sset[m] = this->n;
        this->sset[m + 1] = 0;
    };
    short xcombination::getfirst()
    {
        return (this->n >= this->m) ? this->m : -1;
    };
    short xcombination::getnext()    // ������������ ��������� ������ ��������  
    {
        short rc = getfirst();
        if (rc > 0)
        {

            short j;
            for (j = 0; this->sset[j] + 1 == this->sset[j + 1]; ++j)
                this->sset[j] = j;
            if (j >= this->m) rc = -1;
            else {
                this->sset[j]++;
                this->nc++;

            };

        }
        return rc;
    };
    short xcombination::ntx(short i)
    {
        return this->sset[i];
    };

    unsigned __int64 facto(unsigned __int64 x) { return(x == 0) ? 1 : (x * facto(x - 1)); };

    unsigned __int64 xcombination::count() const
    {
        return (this->n >= this->m) ?
            facto(this->n) / (facto(this->n - this->m) * facto(this->m)) : 0;
    };
};
