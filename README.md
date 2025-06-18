# 自包含的 CMake + Ninja + vcpkg 基础工程

[![Platform](https://img.shields.io/badge/platform-Windows%20%7C%20Linux%20%7C%20macOS-brightgreen)](https://github.com)
[![CMake](https://img.shields.io/badge/CMake-3.21%2B-blue)](https://cmake.org/)
[![vcpkg](https://img.shields.io/badge/vcpkg-latest-orange)](https://vcpkg.io/)
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)

这是一个**完全自包含**的现代C++项目模板，集成了业界最佳实践：

- **🎯 零配置**：克隆即用，无需预装工具
- **🤖 智能检测**：自动检测编译器和平台
- **📦 依赖管理**：vcpkg 自动管理所有 C++ 库
- **⚡ 快速构建**：Ninja 提供极速增量编译
- **🔧 一键构建**：单个命令完成所有操作
- **🌍 真正跨平台**：三大平台统一开发体验

## ✨ 特性

- **🎯 零配置**：克隆即用，无需预装工具
- **🤖 智能检测**：自动检测编译器和平台
- **📦 依赖管理**：vcpkg 自动管理所有 C++ 库
- **⚡ 快速构建**：Ninja 提供极速增量编译
- **🔧 一键构建**：单个命令完成所有操作
- **🌍 真正跨平台**：三大平台统一开发体验

## 🎬 快速演示

### Windows
```bash
git clone <your-repo>
cd your-project
.\scripts\build.bat        # 🎉 一键完成所有操作！
```

### Linux / macOS
```bash
git clone <your-repo>
cd your-project
chmod +x ./scripts/build.sh
./scripts/build.sh         # 🎉 一键完成所有操作！
```

就这么简单！项目会自动：
- 下载并构建 vcpkg
- 下载 ninja 构建工具
- 安装项目依赖 (fmt, spdlog)
- 配置并构建项目
- 运行生成的程序

## 🛠️ 系统要求

### 最小依赖
只需要系统安装这些基础工具：

| 工具 | Windows | Linux | macOS |
|-----|---------|-------|-------|
| **CMake** | 3.21+ | 3.21+ | 3.21+ |
| **编译器** | Visual Studio 2019/2022 | GCC 或 Clang | Xcode Command Line Tools |
| **Git** | ✅ | ✅ | ✅ |

### 🐧 Linux 系统要求

在使用项目之前，请确保安装了以下必需工具：

#### Ubuntu/Debian 系统
```bash
# 安装所有必需工具（推荐）
sudo apt update
sudo apt install git cmake curl pkg-config build-essential zip unzip tar

# 或者分别安装
sudo apt install git              # 版本控制工具
sudo apt install cmake           # 构建系统
sudo apt install curl            # 网络下载工具
sudo apt install pkg-config      # 包配置工具
sudo apt install build-essential # C++ 编译器和基础工具
sudo apt install zip unzip tar   # 压缩文件处理工具
```

#### CentOS/RHEL/Fedora 系统
```bash
# RHEL/CentOS 8+
sudo dnf install git cmake curl pkgconfig gcc gcc-c++ make zip unzip tar

# 或者较老的系统
sudo yum install git cmake curl pkgconfig gcc gcc-c++ make zip unzip tar
```

#### Arch Linux 系统
```bash
# 安装所有必需工具
sudo pacman -S git cmake curl pkgconf base-devel zip unzip tar
```

#### openSUSE 系统
```bash
# 安装所有必需工具
sudo zypper install git cmake curl pkg-config gcc gcc-c++ make zip unzip tar
```

### 🍎 macOS 系统要求

```bash
# 安装 Xcode Command Line Tools（包含编译器）
xcode-select --install

# 如果使用 Homebrew，安装其他工具
brew install git cmake curl pkg-config
```

### 自动提供的工具
这些工具会被**自动下载**，无需手动安装：
- ✅ vcpkg (Microsoft C++ 包管理器)
- ✅ Ninja (高性能构建工具)
- ✅ 所有 C++ 依赖包

### ⚡ 自动安装（可选）

如果你不想手动安装这些工具，项目的 `setup.sh` 脚本可以**自动检测和安装**缺失的工具：

```bash
# 运行自动安装脚本
chmod +x ./scripts/setup.sh
./scripts/setup.sh

# 脚本会自动：
# ✅ 检测缺失的工具
# ✅ 使用系统包管理器安装
# ✅ 验证安装结果
# ✅ 继续项目初始化
```

**注意**：自动安装需要 sudo 权限来安装系统包。

## 📁 项目结构

```
📁 project/
├── 📁 src/                    # 源代码
│   ├── 📄 main.cpp           # 程序入口
│   └── 📄 utils.cpp          # 工具类实现
├── 📁 include/               # 头文件
│   └── 📄 utils.h            # 工具类头文件
├── 📁 tools/                 # 🤖 工具目录（自动生成）
│   ├── 📁 vcpkg/            # vcpkg 工具链
│   ├── 📁 ninja/            # ninja 构建器
│   └── 📁 cmake/            # CMake 辅助脚本
├── 📁 scripts/              # 🎯 一键构建脚本
│   ├── 🖥️ setup.bat          # Windows 初始化
│   ├── 🐧 setup.sh           # Linux/macOS 初始化  
│   ├── 🖥️ build.bat          # Windows 一键构建
│   ├── 🐧 build.sh           # Linux/macOS 一键构建
│   ├── 🖥️ clean.bat          # Windows 清理
│   ├── 🐧 clean.sh           # Linux/macOS 清理
│   ├── 🖥️ clean_all.bat      # Windows 完全清理
│   └── 🐧 clean_all.sh       # Linux/macOS 完全清理
├── ⚙️ CMakePresets.json      # CMake 预设配置
├── 📦 vcpkg.json            # 依赖包清单
├── 🏗️ CMakeLists.txt        # CMake 构建配置
└── 📖 README.md             # 项目文档
```

## 🎯 使用指南

### 🏃‍♂️ 快速开始（推荐）

最简单的方式就是使用一键构建脚本：

#### Windows
```bash
# 克隆项目后直接运行
.\scripts\build.bat
```

#### Linux / macOS  
```bash
# 克隆项目后运行
chmod +x ./scripts/build.sh
./scripts/build.sh
```

### � 手动构建（高级用户）

如果你想了解构建过程或需要自定义配置：

#### Windows
```bash
# 1️⃣ 初始化工具（仅首次需要）
.\scripts\setup.bat

# 2️⃣ 配置项目
cmake --preset=default

# 3️⃣ 构建项目  
cmake --build --preset=default

# 4️⃣ 运行程序
.\build\Release\MyApp.exe
```

#### Linux / macOS
```bash
# 1️⃣ 初始化工具（仅首次需要）
./scripts/setup.sh

# 2️⃣ 配置项目
cmake --preset=default-linux

# 3️⃣ 构建项目
cmake --build --preset=default-linux

# 4️⃣ 运行程序
./build/Release/MyApp
```

## 📦 依赖管理

### 添加新依赖

编辑 `vcpkg.json` 文件，添加你需要的库：

```json
{
  "name": "myapp",
  "version": "1.0.0",
  "dependencies": [
    "fmt",           // 现代 C++ 格式化库
    "spdlog",        // 高性能日志库
    "nlohmann-json", // JSON 库
    "boost-system",  // Boost 系统库
    "curl",          // HTTP 客户端
    "sqlite3"        // SQLite 数据库
  ]
}
```

然后重新构建项目，vcpkg 会自动下载并编译新的依赖。

### 在代码中使用

更新 `CMakeLists.txt`：
```cmake
find_package(nlohmann_json CONFIG REQUIRED)
find_package(unofficial-sqlite3 CONFIG REQUIRED)

target_link_libraries(${PROJECT_NAME} PRIVATE 
    fmt::fmt 
    spdlog::spdlog
    nlohmann_json::nlohmann_json
    unofficial::sqlite3::sqlite3
)
```

## ⚙️ 配置选项

### 构建类型

| 预设名称 | 平台 | 类型 | 用途 |
|---------|------|------|------|
| `default` | Windows | Release | 🚀 生产环境 |
| `debug` | Windows | Debug | 🐛 调试开发 |
| `default-linux` | Linux/macOS | Release | 🚀 生产环境 |
| `debug-linux` | Linux/macOS | Debug | 🐛 调试开发 |

### 指定编译器

#### Windows
项目自动检测 Visual Studio：
- Visual Studio 2022 (Community/Professional/Enterprise)
- Visual Studio 2019 (Community/Professional/Enterprise)

#### Linux/macOS
```bash
# 使用 GCC
export CC=gcc CXX=g++

# 使用 Clang  
export CC=clang CXX=clang++
```

## 🧹 项目清理

项目提供了两种清理模式：

### 快速清理（推荐）
只清理构建文件，保留下载的工具，下次构建更快：

#### Windows
```bash
.\scripts\clean.bat
```

#### Linux/macOS
```bash
./scripts/clean.sh
```

**清理内容**：
- ✅ `build/` 目录
- ✅ vcpkg 缓存（buildtrees, downloads, packages）
- ✅ CMake 缓存文件
- ❌ **保留** vcpkg 和 ninja 工具

### 完全清理
清理所有文件，包括下载的工具（下次构建需要重新下载）：

#### Windows
```bash
.\scripts\clean_all.bat
```

#### Linux/macOS
```bash
./scripts/clean_all.sh
```

**清理内容**：
- ✅ `build/` 目录
- ✅ `tools/vcpkg/` 整个目录
- ✅ `tools/ninja/` 整个目录

### 使用建议

| 场景 | 推荐脚本 | 原因 |
|------|---------|------|
| 日常开发清理 | `clean.bat/.sh` | 保留工具，清理更快 |
| 依赖包冲突 | `clean.bat/.sh` | 清理vcpkg缓存解决问题 |
| 完全重置 | `clean_all.bat/.sh` | 彻底清理，重新开始 |
| 节省磁盘空间 | `clean_all.bat/.sh` | 释放所有占用空间 |

## 🐛 故障排除

### 常见问题和解决方案

| 问题 | 平台 | 解决方案 |
|------|------|----------|
| 编译器未找到 | Windows | 安装 Visual Studio 2019/2022 + C++ 开发工具 |
| 编译器未找到 | Linux | `sudo apt install build-essential` |
| 编译器未找到 | macOS | `xcode-select --install` |
| 网络连接问题 | 全平台 | 检查防火墙，或使用企业网络代理 |
| 权限错误 | Linux/macOS | `chmod +x scripts/*.sh` |
| vcpkg 构建失败 | 全平台 | 删除 `tools/vcpkg` 目录后重新运行 |

### 完全重置项目

如果遇到无法解决的问题：

#### Windows
```bash
.\scripts\clean_all.bat  # 清理所有生成文件
.\scripts\setup.bat      # 重新初始化
```

#### Linux/macOS
```bash
./scripts/clean_all.sh   # 清理所有生成文件  
./scripts/setup.sh       # 重新初始化
```

## 🎨 自定义和扩展

### 添加新的源文件

项目使用 `GLOB_RECURSE` 自动收集源文件：
- 添加 `.cpp/.c` 文件到 `src/` 目录
- 添加 `.h/.hpp` 文件到 `include/` 目录
- 重新构建即可

### 创建库项目

修改 `CMakeLists.txt`：
```cmake
# 创建静态库而不是可执行文件
add_library(${PROJECT_NAME} STATIC ${SOURCES} ${HEADERS})

# 或创建共享库
add_library(${PROJECT_NAME} SHARED ${SOURCES} ${HEADERS})
```

### 添加测试

项目预留了测试支持：
```bash
cmake --preset=default -DBUILD_TESTS=ON
cmake --build --preset=default
ctest
```

## 🤝 贡献指南

欢迎提交 Issue 和 Pull Request！

### 开发环境设置
1. Fork 这个项目
2. 克隆你的 fork：`git clone <your-fork>`
3. 运行构建脚本验证环境
4. 创建功能分支：`git checkout -b feature-name`
5. 提交你的更改并推送
6. 创建 Pull Request

### 代码规范
- 使用现代 C++17 标准
- 遵循 CMake 最佳实践
- 保持跨平台兼容性
- 添加适当的注释和文档

## 📄 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。

## 🙏 致谢

- [Microsoft vcpkg](https://vcpkg.io/) - 优秀的 C++ 包管理器
- [Ninja Build System](https://ninja-build.org/) - 高性能构建工具
- [CMake](https://cmake.org/) - 跨平台构建系统
- [fmt](https://github.com/fmtlib/fmt) - 现代 C++ 格式化库

---

⭐ **如果这个项目对你有帮助，请给它一个 Star！**

📧 **有问题？** [提交 Issue](../../issues) 或 [开始讨论](../../discussions)