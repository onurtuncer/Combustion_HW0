[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

# Combustion Homework-0

Cantera setup for ITU UCK-427E Combustion course students.

# C++ Development Environment Setup for CANTERA 

**Platform:** Windows 10/11 (x86_64)  
**Toolchain:** MSVC (Visual Studio 2022)  
**Package Manager:** Miniforge (conda-forge)  
**Build System:** CMake  
**Editor:** VS Code
**Version Control:** git

A clean, reproducible, ground-up installation for a **pure C++ workflow** for **Cantera** library and its third-party dependencies as conda-forge C++ packages is described here. This way every student will have exactly the same build environment.

---

# 0. Install MSVC Compiler 

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

After succesful compilation now run the compiler executable (cl.exe) at the "Developer Command Prompt". 
You should see a similiar output if installation is successful.

```bash
C:\Program Files\Microsoft Visual Studio\18\Community>cl
Microsoft (R) C/C++ Optimizing Compiler Version 19.50.35720 for x86
Copyright (C) Microsoft Corporation.  All rights reserved.

usage: cl [ option... ] filename... [ /link linkoption... ]
```

# 1. Install Visual Studio Code and git

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
---

# 2. Install Miniforge

Miniforge is used only as a binary package manager for C/C++ libraries via conda-forge.

## 2.1 Download

Download: 

Miniforge3-Windows-x86_64.exe

From:

https://github.com/conda-forge/miniforge/releases

---

## 2.2 Install

During installation:

- ✔ Just Me
- ✔ Add to PATH (recommended)
- ✔ Register Miniforge as default Python (required by conda internally)

Finish installation.

---

## 2.3 Verify

Open **Miniforge Prompt**:

```bash
conda --version
```

You should see,

```bash
conda 24.x.x
```
---

# 3. Create Dedicated C++ Environment

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

Once the environment is active you should see its name inside parantheses at the command prompt.

---

# 4. Install Required C++ Libraries

All packages are installed from conda-forge.

## 4.1 Install CMake

```bash
conda install -c conda-forge cmake
```

Verify:

```bash
cmake --version
```

---

## 4.2 Install Ninja (Optional but Recommended)

```bash
conda install -c conda-forge ninja
```
---

## 4.3 Install Cantera (C++ Development)

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

---

# 5. Compilation

## 5.1 Run VS Code

At the miniforge command prompt change directory to where you have downloaded (or cloned) "Combustion_HW0" repository. Make 
sure your development environment is active if not then activate it as instructed before.Type the following command 
so that VSCode starts with inheriting the correct environment variables for yor setup.

```bash
code .
```

## 5.2 Build Demo Executable

Open a terminal window inside VS Code. Create a build directory.

```bash
mkdir build
```

Never clutter your original directories with build artifacts and keep them out-of source control at all times. That is why your ".gitignore" file lists "build" and all subdirectories to be ignored. Do check it out. 

Under ***cmake*** directory your ***FindCantera.cmake*** module does all the heavy lifting for finding and linking necessary libraries and third-party dependencies. Read it but do not touch it. 

***CMakeLists.txt*** at the root directory of your repo is responsible for compiling the ***demo*** executable. For your homework stuff you will need to modify this file accordingly. Since our demo is a very simple one all the source code is in a single translation unit (e.g. cpp file) named ***main.cpp***. For the homeworks obviously you will write your own source code. 

Now let u



Now run the compiled executable which you should find under the "Release" folder. You should see this output.

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
Congragulations, you are all set!..

Note: Always build your executables with "Release" configuration since your ***CANTERA*** installation is built only with this configuration.
If you try other configurations (e.g. "Debug" or "ReleaseWithDebugInfo") you will get linker errors!

---


## 👤 Author

**Prof.Dr. Onur Tuncer**  
Mechanical Engineer, Researcher & C++ Systems Developer  
Email: **onur.tuncer@itu.edu.tr**

<p align="left">
  <img src="assets/itu_logo.png" width="180" alt="Istanbul Technical University"/>
</p>







