[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

# Combustion Homework-0

Cantera setup for ITU UCK427E Combustion course students.

# C++ Development Environment Setup for CANTERA 

**Platform:** Windows 10/11 (x86_64)  
**Toolchain:** MSVC (Visual Studio 2022)  
**Package Manager:** Miniforge (conda-forge)  
**Build System:** CMake  
**Editor:** VS Code
**Version Control:** git

A clean, reproducible, ground-up installation for a **pure C++ workflow** for **Cantera** library and its third-party dependencies as conda-forge C++ packages is described here. This way every student will have exactly the same build environment.

---

# 0. Install Visual Studio Code and git

Make sure that VS-Code is installed on your machine. If not then download and install. Also install the following VS Code extensions for convenience. They provide features such as syntax highlighting, intelli-sense etc.

- C/C++
- C/C++ Extension Pack
- CMake 
- CMake Tools

Using git for version control is the most practical approach. After installing git on Windows you can open the git bash command prompt
and clone this repository into your development folder. Type the following command to clone this repo.

```bash
git clone https://github.com/onurtuncer/Combustion_HW0.git
```

# 1. Install Miniforge

Miniforge is used only as a binary package manager for C/C++ libraries via conda-forge.

## 1.1 Download

Download: 

Miniforge3-Windows-x86_64.exe

From:

https://github.com/conda-forge/miniforge/releases

---

## 1.2 Install

During installation:

- ✔ Just Me
- ✔ Add to PATH (recommended)
- ✔ Register Miniforge as default Python (required by conda internally)

Finish installation.

---

## 1.3 Verify

Open **Miniforge Prompt**:

```bash
conda --version
```

You should see,

```bash
conda 24.x.x
```

# 2. Create Dedicated C++ Environment

Navigate to your project root:

```bash
cd path\to\your-project
```

Create an isolated environment:

```bash
conda create -n cpp_env
```

Activate it:

```bash
conda activate cpp_env
```

# 3. Install Required C++ Libraries

All packages are installed from conda-forge.

## 3.1 Install CMake

```bash
conda install -c conda-forge cmake
```

Verify:

```bash
cmake --version
```

## 3.2 Install Ninja (Optional but Recommended)

```bash
conda install -c conda-forge ninja
```

## 3.3 Install Cantera (C++ Development)

```bash
conda install -c conda-forge cantera-devel
```

This installs:

- Headers
- Static/Dynamic libraries
- CMake configuration files

Verify installation directory:

```bash
echo %CONDA_PREFIX%
```

# 4. Install MSVC Compiler 

If you do not already have MSVC compiler for C/C++ development you must install it on your machine in one of the following ways.

## Option A (Recommended for Students)

Visual Studio 2022 Community

Select: ✔ Desktop development with C++

This installs:

- MSVC compiler (cl.exe)
- Windows SDK
- CMake integration
- Debugger

## Option B (Lightweight)

Build Tools for Visual Studio 2022

Install only:

- MSVC v143
- Windows SDK

No IDE, just compiler.

After succesful compilation now run the executable. You should see the following output.

```bash
PS D:\Dev\Combustion_HW0\build> .\Release\demo.exe
Starting...
T [K]      = 300
P [Pa]     = 101325
h [J/kg]   = -254587
s [J/kg-K] = 7247.7
cp [J/kg-K]= 1077.33
T_ad [K]   = 2225.52
```
Congragulations!..


## 👤 Author

**Prof.Dr. Onur Tuncer**  
Mechanical Engineer, Researcher & C++ Systems Developer  
Email: **onur.tuncer@itu.edu.tr**

<p align="left">
  <img src="assets/itu_logo.png" width="180" alt="Istanbul Technical University"/>
</p>







