#pragma once

namespace MyMath {

class Calculator {
public:
    static double add(double a, double b);
    static double subtract(double a, double b);
    static double multiply(double a, double b);
    static double divide(double a, double b);
    
    // 高级数学函数
    static double power(double base, double exponent);
    static double sqrt(double value);
    static double factorial(int n);
};

} // namespace MyMath