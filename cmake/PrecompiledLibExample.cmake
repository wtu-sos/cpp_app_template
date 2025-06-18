# 添加预编译库的示例
# 假设你有一个预编译的库放在 libs/precompiled 目录

# 设置库的路径
set(PRECOMPILED_LIB_DIR ${CMAKE_SOURCE_DIR}/libs/precompiled)

# 查找库文件
find_library(MY_PRECOMPILED_LIB
    NAMES my_custom_lib libmy_custom_lib
    PATHS ${PRECOMPILED_LIB_DIR}/lib
    NO_DEFAULT_PATH
)

# 检查是否找到库
if(MY_PRECOMPILED_LIB)
    message(STATUS "找到预编译库: ${MY_PRECOMPILED_LIB}")
    
    # 创建导入的库目标
    add_library(MyPrecompiled::Lib STATIC IMPORTED)
    
    # 设置库的位置
    set_target_properties(MyPrecompiled::Lib PROPERTIES
        IMPORTED_LOCATION ${MY_PRECOMPILED_LIB}
        INTERFACE_INCLUDE_DIRECTORIES ${PRECOMPILED_LIB_DIR}/include
    )
    
    # 在主目标中链接
    target_link_libraries(${PROJECT_NAME} PRIVATE MyPrecompiled::Lib)
    
else()
    message(WARNING "未找到预编译库")
endif()