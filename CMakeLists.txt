cmake_minimum_required(VERSION 3.21)

# 设置项目信息
project(MyApp 
    VERSION 1.0.0
    LANGUAGES CXX
    DESCRIPTION "自包含的CMake+Ninja+vcpkg基础工程"
)

# 设置C++标准
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# 设置输出目录
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${CMAKE_BUILD_TYPE})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${CMAKE_BUILD_TYPE})
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${CMAKE_BUILD_TYPE})

# 包含工具目录
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/tools/cmake")

# 自动检测和设置vcpkg
include(vcpkg-setup)

# 首先添加自定义库的子目录
add_subdirectory(libs/my-math-lib)

# 查找依赖包
find_package(fmt CONFIG REQUIRED)
find_package(spdlog CONFIG REQUIRED)

# 可选依赖包（根据需要取消注释）
# find_package(nlohmann_json CONFIG REQUIRED)
# find_package(Boost REQUIRED COMPONENTS system)
# find_package(CURL CONFIG REQUIRED)
# find_package(unofficial-sqlite3 CONFIG REQUIRED)
# find_package(OpenSSL REQUIRED)
# find_package(protobuf CONFIG REQUIRED)
# find_package(gRPC CONFIG REQUIRED)
# find_package(opencv CONFIG REQUIRED)
# find_package(Eigen3 CONFIG REQUIRED)
# find_package(Catch2 CONFIG REQUIRED)

# 包含目录
include_directories(${CMAKE_SOURCE_DIR}/include)

# 添加源文件
file(GLOB_RECURSE SOURCES "src/*.cpp" "src/*.c")
file(GLOB_RECURSE HEADERS "include/*.h" "include/*.hpp")

# 创建可执行文件
add_executable(${PROJECT_NAME} ${SOURCES} ${HEADERS})

# 链接基础库
target_link_libraries(${PROJECT_NAME} PRIVATE 
    fmt::fmt
    spdlog::spdlog
    MyMath::MathLib  # 自定义数学库
)

# 可选库链接（根据需要取消注释）
# target_link_libraries(${PROJECT_NAME} PRIVATE 
#     nlohmann_json::nlohmann_json
#     Boost::system
#     CURL::libcurl
#     unofficial::sqlite3::sqlite3
#     OpenSSL::SSL OpenSSL::Crypto
#     protobuf::libprotobuf
#     gRPC::grpc++
#     opencv_core opencv_imgproc opencv_imgcodecs
#     Eigen3::Eigen
# )

# 测试库链接（仅在构建测试时）
if(BUILD_TESTS)
    # target_link_libraries(tests PRIVATE Catch2::Catch2WithMain)
endif()

# 设置编译器选项
if(MSVC)
    target_compile_options(${PROJECT_NAME} PRIVATE /W4)
else()
    target_compile_options(${PROJECT_NAME} PRIVATE -Wall -Wextra -Wpedantic)
endif()

# 启用调试信息（Debug模式）
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    target_compile_definitions(${PROJECT_NAME} PRIVATE DEBUG=1)
endif()

# 安装规则
install(TARGETS ${PROJECT_NAME}
    RUNTIME DESTINATION bin
)

# 添加测试支持
option(BUILD_TESTS "Build tests" OFF)
if(BUILD_TESTS)
    enable_testing()
    add_subdirectory(tests)
endif()

# 打印构建信息
message(STATUS "项目名称: ${PROJECT_NAME}")
message(STATUS "项目版本: ${PROJECT_VERSION}")
message(STATUS "构建类型: ${CMAKE_BUILD_TYPE}")
message(STATUS "编译器: ${CMAKE_CXX_COMPILER_ID} ${CMAKE_CXX_COMPILER_VERSION}")
message(STATUS "输出目录: ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}")