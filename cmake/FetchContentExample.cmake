# FetchContent 示例 - 获取远程自定义库
include(FetchContent)

# 获取自定义库
FetchContent_Declare(
    MyCustomLib
    GIT_REPOSITORY https://github.com/your-org/your-custom-lib.git
    GIT_TAG        v1.0.0  # 或者使用 main/master
    GIT_SHALLOW    TRUE
)

# 让CMake处理下载和配置
FetchContent_MakeAvailable(MyCustomLib)

# 如果库没有提供CMake配置，你可能需要手动设置
# set(MYCUSTOMLIB_INCLUDE_DIR ${mycustomlib_SOURCE_DIR}/include)
# set(MYCUSTOMLIB_LIBRARIES ${mycustomlib_SOURCE_DIR}/lib/libmycustom.a)