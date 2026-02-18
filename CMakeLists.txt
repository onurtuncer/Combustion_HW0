cmake_minimum_required(VERSION 3.20)
project(itu_combustion_cantera_cpp LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Help CMake find packages inside an active Conda env
include(cmake/CanteraHints.cmake)

# Cantera installs a CMake config on many platforms; prefer that if available
#find_package(Cantera CONFIG REQUIRED)

# --- Cantera via Conda on Windows (no CanteraConfig.cmake required) ---
if(WIN32 AND DEFINED ENV{CONDA_PREFIX})
    set(CONDA_PREFIX "$ENV{CONDA_PREFIX}")

    # headers
    find_path(CANTERA_INCLUDE_DIR
        NAMES cantera/base/Solution.h
        PATHS "${CONDA_PREFIX}/Library/include"
        NO_DEFAULT_PATH
    )

    # import library (.lib)
    find_library(CANTERA_LIB
        NAMES cantera libcantera
        PATHS "${CONDA_PREFIX}/Library/lib"
        NO_DEFAULT_PATH
    )

    if(NOT CANTERA_INCLUDE_DIR OR NOT CANTERA_LIB)
        message(FATAL_ERROR "Could not find Cantera headers/libs in conda env: ${CONDA_PREFIX}")
    endif()

    add_library(Cantera::cantera UNKNOWN IMPORTED)
    set_target_properties(Cantera::cantera PROPERTIES
        IMPORTED_LOCATION "${CANTERA_LIB}"
        INTERFACE_INCLUDE_DIRECTORIES "${CANTERA_INCLUDE_DIR}"
    )
else()
    message(FATAL_ERROR "This repo expects Cantera installed in a conda env on Windows.")
endif()

add_executable(demo src/main.cpp)
target_link_libraries(demo PRIVATE Cantera::cantera)
