# My Custom Math Library
cmake_minimum_required(VERSION 3.21)

project(MyMathLib VERSION 1.0.0 LANGUAGES CXX)

# 设置C++标准
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# 添加库的源文件
set(SOURCES
    src/calculator.cpp
)

set(HEADERS
    include/mymath/calculator.h
)

# 创建静态库
add_library(${PROJECT_NAME} STATIC ${SOURCES} ${HEADERS})

# 设置库的别名（推荐做法）
add_library(MyMath::MathLib ALIAS ${PROJECT_NAME})

# 设置包含目录
target_include_directories(${PROJECT_NAME}
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:include>
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/src
)

# 编译选项
if(MSVC)
    target_compile_options(${PROJECT_NAME} PRIVATE /W4)
else()
    target_compile_options(${PROJECT_NAME} PRIVATE -Wall -Wextra -Wpedantic)
endif()

# 导出配置（可选，用于其他项目引用）
install(TARGETS ${PROJECT_NAME}
    EXPORT MyMathLibTargets
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
    RUNTIME DESTINATION bin
    INCLUDES DESTINATION include
)

install(DIRECTORY include/mymath DESTINATION include)

install(EXPORT MyMathLibTargets
    FILE MyMathLibTargets.cmake
    NAMESPACE MyMath::
    DESTINATION lib/cmake/MyMathLib
)