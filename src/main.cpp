#include <fmt/core.h>
#include <spdlog/spdlog.h>
#include <iostream>
#include "utils.h"
#include "mymath/calculator.h"  // 引入自定义库

int main() {
    fmt::print("🚀 欢迎使用 {}\n", MyApp::Utils::getProjectInfo());
    fmt::print("📦 项目版本: {}\n", MyApp::Utils::getVersion());
    fmt::print("⚡ 构建工具: CMake + Ninja + vcpkg\n");
    
    std::cout << "✅ 项目构建成功！" << std::endl;
    
    // 使用自定义数学库
    try {
        auto calc_result = MyMath::Calculator::add(10.5, 20.3);
        fmt::print("计算结果 (10.5 + 20.3): {}\n", calc_result);
        
        auto power_result = MyMath::Calculator::power(2, 8);
        fmt::print("计算结果 (2^8): {}\n", power_result);
        
        auto factorial_result = MyMath::Calculator::factorial(5);
        fmt::print("计算结果 (5!): {}\n", factorial_result);
        
        auto sqrt_result = MyMath::Calculator::sqrt(16.0);
        fmt::print("计算结果 (√16): {}\n", sqrt_result);

        spdlog::info("数学计算完成！");
    } catch (const std::exception& e) {
        spdlog::error("数学计算错误: {}", e.what());
    }

    return 0;
}