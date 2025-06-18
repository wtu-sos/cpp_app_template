# 检测并设置vcpkg工具链
# 这个脚本会自动下载和配置vcpkg，无需用户手动设置

# 设置vcpkg根目录
set(VCPKG_ROOT "${CMAKE_SOURCE_DIR}/tools/vcpkg")
set(NINJA_ROOT "${CMAKE_SOURCE_DIR}/tools/ninja")

# 检查vcpkg是否存在
if(NOT EXISTS "${VCPKG_ROOT}/vcpkg.exe" AND NOT EXISTS "${VCPKG_ROOT}/vcpkg")
    message(STATUS "vcpkg未找到，将自动下载...")
    
    # 下载vcpkg
    find_package(Git REQUIRED)
    execute_process(
        COMMAND ${GIT_EXECUTABLE} clone https://github.com/Microsoft/vcpkg.git ${VCPKG_ROOT}
        RESULT_VARIABLE GIT_RESULT
    )
    
    if(NOT GIT_RESULT EQUAL 0)
        message(FATAL_ERROR "无法下载vcpkg")
    endif()
    
    # 构建vcpkg
    if(WIN32)
        execute_process(
            COMMAND ${VCPKG_ROOT}/bootstrap-vcpkg.bat
            WORKING_DIRECTORY ${VCPKG_ROOT}
            RESULT_VARIABLE BOOTSTRAP_RESULT
        )
    else()
        execute_process(
            COMMAND ${VCPKG_ROOT}/bootstrap-vcpkg.sh
            WORKING_DIRECTORY ${VCPKG_ROOT}
            RESULT_VARIABLE BOOTSTRAP_RESULT
        )
    endif()
    
    if(NOT BOOTSTRAP_RESULT EQUAL 0)
        message(FATAL_ERROR "无法构建vcpkg")
    endif()
    
    message(STATUS "vcpkg安装完成")
endif()

# 检查ninja是否存在
if(WIN32)
    set(NINJA_EXECUTABLE "${NINJA_ROOT}/ninja.exe")
else()
    set(NINJA_EXECUTABLE "${NINJA_ROOT}/ninja")
endif()

if(NOT EXISTS "${NINJA_EXECUTABLE}")
    message(STATUS "ninja未找到，将自动下载...")
    
    # 创建ninja目录
    file(MAKE_DIRECTORY ${NINJA_ROOT})
    
    # 根据平台下载ninja
    if(WIN32)
        set(NINJA_URL "https://github.com/ninja-build/ninja/releases/latest/download/ninja-win.zip")
        set(NINJA_ARCHIVE "${NINJA_ROOT}/ninja-win.zip")
    elseif(APPLE)
        set(NINJA_URL "https://github.com/ninja-build/ninja/releases/latest/download/ninja-mac.zip")
        set(NINJA_ARCHIVE "${NINJA_ROOT}/ninja-mac.zip")
    else()
        set(NINJA_URL "https://github.com/ninja-build/ninja/releases/latest/download/ninja-linux.zip")
        set(NINJA_ARCHIVE "${NINJA_ROOT}/ninja-linux.zip")
    endif()
    
    # 下载ninja
    file(DOWNLOAD ${NINJA_URL} ${NINJA_ARCHIVE}
        SHOW_PROGRESS
        STATUS DOWNLOAD_STATUS
    )
    
    list(GET DOWNLOAD_STATUS 0 DOWNLOAD_RESULT)
    if(NOT DOWNLOAD_RESULT EQUAL 0)
        message(FATAL_ERROR "无法下载ninja")
    endif()
    
    # 解压ninja
    execute_process(
        COMMAND ${CMAKE_COMMAND} -E tar xzf ${NINJA_ARCHIVE}
        WORKING_DIRECTORY ${NINJA_ROOT}
        RESULT_VARIABLE EXTRACT_RESULT
    )
    
    if(NOT EXTRACT_RESULT EQUAL 0)
        message(FATAL_ERROR "无法解压ninja")
    endif()
    
    # 删除压缩包
    file(REMOVE ${NINJA_ARCHIVE})
    
    # 设置执行权限（Unix系统）
    if(NOT WIN32)
        execute_process(
            COMMAND chmod +x ${NINJA_EXECUTABLE}
            RESULT_VARIABLE CHMOD_RESULT
        )
    endif()
    
    message(STATUS "ninja安装完成")
endif()

# 设置CMake变量
set(CMAKE_TOOLCHAIN_FILE "${VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake" CACHE STRING "")
set(CMAKE_MAKE_PROGRAM "${NINJA_EXECUTABLE}" CACHE STRING "")

message(STATUS "vcpkg路径: ${VCPKG_ROOT}")
message(STATUS "ninja路径: ${NINJA_EXECUTABLE}")
message(STATUS "工具链文件: ${CMAKE_TOOLCHAIN_FILE}")