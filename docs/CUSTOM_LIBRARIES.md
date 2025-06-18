# 🔧 添加自定义库指南

本文档详细说明如何在项目中集成你的自定义库。

## 📋 目录

- [方法1: Git 子模块](#方法1-git-子模块推荐)
- [方法2: FetchContent 远程获取](#方法2-fetchcontent-远程获取)
- [方法3: 预编译库](#方法3-预编译库)
- [方法4: Header-Only 库](#方法4-header-only-库)
- [完整示例](#完整示例)

---

## 方法1: Git 子模块（推荐）

适用于：有 Git 仓库的自定义库

### 🚀 快速开始

```bash
# 1. 添加子模块
git submodule add https://github.com/your-org/your-lib.git libs/your-lib

# 2. 初始化和更新子模块
git submodule update --init --recursive
```

### 📁 目录结构

```
project/
├── libs/
│   ├── my-math-lib/          # 自定义数学库
│   │   ├── CMakeLists.txt
│   │   ├── include/
│   │   │   └── mymath/
│   │   │       ├── calculator.h
│   │   │       └── matrix.h
│   │   └── src/
│   │       ├── calculator.cpp
│   │       └── matrix.cpp
│   └── my-network-lib/       # 另一个自定义库
│       ├── CMakeLists.txt
│       └── ...
└── CMakeLists.txt           # 主项目
```

### ⚙️ CMake 配置

在主项目的 `CMakeLists.txt` 中：

```cmake
# 添加子库
add_subdirectory(libs/my-math-lib)
add_subdirectory(libs/my-network-lib)

# 链接库
target_link_libraries(${PROJECT_NAME} PRIVATE 
    MyMath::MathLib
    MyNetwork::NetworkLib
)
```

### 📝 库的 CMakeLists.txt 模板

```cmake
# libs/my-math-lib/CMakeLists.txt
cmake_minimum_required(VERSION 3.21)
project(MyMathLib VERSION 1.0.0 LANGUAGES CXX)

# 创建库
add_library(${PROJECT_NAME} STATIC
    src/calculator.cpp
    src/matrix.cpp
)

# 设置别名（推荐）
add_library(MyMath::MathLib ALIAS ${PROJECT_NAME})

# 包含目录
target_include_directories(${PROJECT_NAME}
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:include>
)

# 编译选项
target_compile_features(${PROJECT_NAME} PUBLIC cxx_std_17)
```

---

## 方法2: FetchContent 远程获取

适用于：远程 Git 仓库的库

### ⚙️ CMake 配置

```cmake
include(FetchContent)

# 声明要获取的库
FetchContent_Declare(
    MyCustomLib
    GIT_REPOSITORY https://github.com/your-org/your-lib.git
    GIT_TAG        v1.2.3  # 建议指定版本标签
    GIT_SHALLOW    TRUE    # 只下载最新提交
)

# 让 CMake 处理下载和构建
FetchContent_MakeAvailable(MyCustomLib)

# 链接库
target_link_libraries(${PROJECT_NAME} PRIVATE MyCustomLib)
```

### 🔄 高级用法

```cmake
# 检查是否已经获取
FetchContent_GetProperties(MyCustomLib)
if(NOT mycustomlib_POPULATED)
    FetchContent_Populate(MyCustomLib)
    
    # 自定义配置
    set(MYCUSTOMLIB_BUILD_TESTS OFF CACHE BOOL "" FORCE)
    set(MYCUSTOMLIB_BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)
    
    add_subdirectory(${mycustomlib_SOURCE_DIR} ${mycustomlib_BINARY_DIR})
endif()
```

---

## 方法3: 预编译库

适用于：已编译的静态/动态库

### 📁 目录结构

```
libs/precompiled/
├── include/
│   └── mylib/
│       └── api.h
├── lib/
│   ├── Windows/
│   │   ├── mylib.lib      # Windows 静态库
│   │   └── mylib.dll      # Windows 动态库
│   ├── Linux/
│   │   ├── libmylib.a     # Linux 静态库
│   │   └── libmylib.so    # Linux 动态库
│   └── macOS/
│       ├── libmylib.a     # macOS 静态库
│       └── libmylib.dylib # macOS 动态库
```

### ⚙️ CMake 配置

```cmake
# 设置库路径
set(PRECOMPILED_ROOT ${CMAKE_SOURCE_DIR}/libs/precompiled)

# 根据平台选择库目录
if(WIN32)
    set(LIB_PLATFORM "Windows")
    set(LIB_SUFFIX ".lib")
elseif(APPLE)
    set(LIB_PLATFORM "macOS") 
    set(LIB_SUFFIX ".a")
else()
    set(LIB_PLATFORM "Linux")
    set(LIB_SUFFIX ".a")
endif()

# 查找库文件
find_library(MY_PRECOMPILED_LIB
    NAMES mylib libmylib
    PATHS ${PRECOMPILED_ROOT}/lib/${LIB_PLATFORM}
    NO_DEFAULT_PATH
)

if(MY_PRECOMPILED_LIB)
    # 创建导入库
    add_library(MyPrecompiled::Lib STATIC IMPORTED)
    
    set_target_properties(MyPrecompiled::Lib PROPERTIES
        IMPORTED_LOCATION ${MY_PRECOMPILED_LIB}
        INTERFACE_INCLUDE_DIRECTORIES ${PRECOMPILED_ROOT}/include
    )
    
    # 链接库
    target_link_libraries(${PROJECT_NAME} PRIVATE MyPrecompiled::Lib)
else()
    message(FATAL_ERROR "未找到预编译库")
endif()
```

---

## 方法4: Header-Only 库

适用于：只有头文件的库

### 📁 目录结构

```
libs/header-only/
├── single-header/
│   └── mylib.hpp          # 单头文件库
└── multi-header/
    └── mylib/
        ├── core.hpp
        ├── utils.hpp
        └── math.hpp
```

### ⚙️ CMake 配置

```cmake
# 方法1: 直接包含目录
target_include_directories(${PROJECT_NAME} PRIVATE 
    ${CMAKE_SOURCE_DIR}/libs/header-only
)

# 方法2: 创建接口库（推荐）
add_library(MyHeaderLib INTERFACE)
target_include_directories(MyHeaderLib INTERFACE
    ${CMAKE_SOURCE_DIR}/libs/header-only
)

# 创建别名
add_library(MyLib::HeaderOnly ALIAS MyHeaderLib)

# 链接
target_link_libraries(${PROJECT_NAME} PRIVATE MyLib::HeaderOnly)
```

---

## 🎯 完整示例

以下是一个完整的自定义库集成示例：

### 主项目 CMakeLists.txt

```cmake
cmake_minimum_required(VERSION 3.21)
project(MyApp VERSION 1.0.0 LANGUAGES CXX)

# ===== 自定义库配置 =====

# 方法1: 子模块库
add_subdirectory(libs/my-math-lib)

# 方法2: FetchContent 库
include(FetchContent)
FetchContent_Declare(
    json
    GIT_REPOSITORY https://github.com/nlohmann/json.git
    GIT_TAG v3.11.2
)
FetchContent_MakeAvailable(json)

# 方法3: 预编译库
include(cmake/PrecompiledLib.cmake)

# 方法4: Header-Only 库
add_library(MyHeaderLib INTERFACE)
target_include_directories(MyHeaderLib INTERFACE libs/header-only)
add_library(MyLib::HeaderOnly ALIAS MyHeaderLib)

# ===== 主程序配置 =====

# 添加源文件
add_executable(${PROJECT_NAME} src/main.cpp)

# 链接所有库
target_link_libraries(${PROJECT_NAME} PRIVATE
    # vcpkg 库
    fmt::fmt
    spdlog::spdlog
    
    # 自定义库
    MyMath::MathLib           # 子模块库
    nlohmann_json::nlohmann_json  # FetchContent 库
    MyPrecompiled::Lib        # 预编译库
    MyLib::HeaderOnly         # Header-Only 库
)
```

### 使用示例 (main.cpp)

```cpp
#include <fmt/format.h>
#include <spdlog/spdlog.h>

// 自定义库
#include "mymath/calculator.h"     // 子模块库
#include <nlohmann/json.hpp>       // FetchContent 库
#include "precompiled/api.h"       // 预编译库
#include "headeronly/utils.hpp"    // Header-Only 库

int main() {
    // 使用各种库
    auto result = MyMath::Calculator::add(1.0, 2.0);
    
    nlohmann::json config = {{"version", "1.0"}, {"debug", true}};
    
    auto status = PrecompiledLib::initialize();
    
    auto timestamp = HeaderOnlyUtils::getCurrentTime();
    
    spdlog::info("所有库集成成功！");
    return 0;
}
```

---

## 🔧 最佳实践

### ✅ 推荐做法

1. **使用命名空间别名**：`MyLib::Component`
2. **指定库版本**：避免使用 `main` 分支，使用稳定版本标签
3. **分离库配置**：将复杂的库配置放在单独的 `.cmake` 文件中
4. **设置构建选项**：关闭不需要的库功能（测试、示例等）
5. **文档化依赖**：在 README 中说明自定义库的用途和版本

### ❌ 避免的做法

1. **硬编码路径**：使用 `CMAKE_SOURCE_DIR` 等变量
2. **忽略平台差异**：不同平台的库文件命名和位置可能不同
3. **版本冲突**：多个库依赖同一个库的不同版本
4. **过度依赖**：引入不必要的重型库

---

## 🔍 故障排除

### 常见问题

| 问题 | 解决方案 |
|------|----------|
| 找不到头文件 | 检查 `target_include_directories` 路径 |
| 链接错误 | 确认库名称和 `target_link_libraries` 配置 |
| 版本冲突 | 使用 `find_package` 的版本要求参数 |
| 子模块为空 | 运行 `git submodule update --init` |
| 编译错误 | 检查 C++ 标准兼容性 |

### 调试技巧

```cmake
# 打印变量值
message(STATUS "库路径: ${MY_LIB_PATH}")

# 查看目标属性
get_target_property(INCLUDES MyLib::Component INTERFACE_INCLUDE_DIRECTORIES)
message(STATUS "包含目录: ${INCLUDES}")

# 列出链接库
get_target_property(LINKED_LIBS ${PROJECT_NAME} LINK_LIBRARIES)
message(STATUS "链接的库: ${LINKED_LIBS}")
```

---

## 📚 更多资源

- [CMake 官方文档](https://cmake.org/documentation/)
- [vcpkg 包管理器](https://vcpkg.io/)
- [Modern CMake 最佳实践](https://cliutils.gitlab.io/modern-cmake/)

---

🎉 **恭喜！** 你现在知道如何在项目中集成任何自定义库了！