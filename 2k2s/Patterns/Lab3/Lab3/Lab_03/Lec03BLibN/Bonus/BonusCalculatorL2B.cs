using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Lec03BLibN;

namespace Lec03LibN
{
    internal class BonusCalculatorL2B : IBonus
    {
        public float CostOneHour { get; set; }
        public float A { get; set; }
        public float X { get; set; }

        public BonusCalculatorL2B(float costOneHour, float a, float x)
        {
            CostOneHour = costOneHour;
            A = a;
            X = x;
        }

        public float Calculate(float numberOfHours)
        {
            return (numberOfHours + A) * CostOneHour * X;
        }
    }
}
