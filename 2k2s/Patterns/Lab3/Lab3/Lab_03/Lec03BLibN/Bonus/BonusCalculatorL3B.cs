using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Lec03BLibN;

namespace Lec03LibN
{
    internal class BonusCalculatorL3B : IBonus
    {
        public float CostOneHour { get; set; }
        public float A { get; set; }
        public float B { get; set; }
        public float X { get; set; }

        public BonusCalculatorL3B(float costOneHour, float a, float b, float x)
        {
            CostOneHour = costOneHour;
            A = a;
            B = b;
            X = x;
        }

        public float Calculate(float numberOfHours)
        {
            return (numberOfHours + A) * (CostOneHour + B) * X;
        }
    }
}
