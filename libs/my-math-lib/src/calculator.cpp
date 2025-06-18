#include "mymath/calculator.h"
#include <cmath>
#include <stdexcept>

namespace MyMath {

double Calculator::add(double a, double b) {
    return a + b;
}

double Calculator::subtract(double a, double b) {
    return a - b;
}

double Calculator::multiply(double a, double b) {
    return a * b;
}

double Calculator::divide(double a, double b) {
    if (b == 0.0) {
        throw std::runtime_error("Division by zero");
    }
    return a / b;
}

double Calculator::power(double base, double exponent) {
    return std::pow(base, exponent);
}

double Calculator::sqrt(double value) {
    if (value < 0.0) {
        throw std::runtime_error("Cannot calculate square root of negative number");
    }
    return std::sqrt(value);
}

double Calculator::factorial(int n) {
    if (n < 0) {
        throw std::runtime_error("Cannot calculate factorial of negative number");
    }
    
    double result = 1.0;
    for (int i = 2; i <= n; ++i) {
        result *= i;
    }
    return result;
}

} // namespace MyMath