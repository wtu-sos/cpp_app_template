#pragma once

#include <string>

namespace MyApp {
    class Utils {
    public:
        static std::string getProjectInfo();
        static std::string getVersion();
    };
}