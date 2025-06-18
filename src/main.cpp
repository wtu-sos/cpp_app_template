#include <fmt/core.h>
#include <iostream>
#include "utils.h"

int main() {
    fmt::print("🚀 欢迎使用 {}\n", MyApp::Utils::getProjectInfo());
    fmt::print("📦 项目版本: {}\n", MyApp::Utils::getVersion());
    fmt::print("⚡ 构建工具: CMake + Ninja + vcpkg\n");
    
    std::cout << "✅ 项目构建成功！" << std::endl;
    
    return 0;
}