#include "utils.h"

namespace MyApp {
    std::string Utils::getProjectInfo() {
        return "自包含的CMake+Ninja+vcpkg基础工程";
    }
    
    std::string Utils::getVersion() {
        return "1.0.0";
    }
}