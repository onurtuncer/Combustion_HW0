# ------------------------------------------------------------------------------
# Project: ITU UCK427E
# Copyright (c) 2025, Onur Tuncer, PhD, Istanbul Technical University
#
# SPDX-License-Identifier: MIT
# License-Filename: LICENSE
# ------------------------------------------------------------------------------

cmake_minimum_required(VERSION 3.20)
project(itu_combustion_cantera_cpp LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Tell CMake where to find FindCantera.cmake
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")

if (MSVC)
  add_compile_options(/utf-8)
endif()

# Use module mode not config mode
find_package(Cantera REQUIRED)

add_executable(demo src/main.cpp)
target_link_libraries(demo PRIVATE Cantera::cantera)

if(MSVC)
  target_compile_options(demo PRIVATE /utf-8)
endif()
