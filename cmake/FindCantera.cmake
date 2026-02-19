include(FindPackageHandleStandardArgs)

# Roots (Conda first)
set(_roots "")
if(DEFINED Cantera_ROOT)
  list(APPEND _roots "${Cantera_ROOT}")
endif()
if(DEFINED ENV{CONDA_PREFIX})
  list(APPEND _roots "$ENV{CONDA_PREFIX}" "$ENV{CONDA_PREFIX}/Library")
endif()

# --- Cantera headers ---
find_path(Cantera_INCLUDE_DIR
  NAMES cantera/base/Solution.h
  PATH_SUFFIXES include
  PATHS ${_roots}
)

# --- Cantera library ---
find_library(Cantera_LIBRARY
  NAMES cantera cantera_shared
  PATH_SUFFIXES lib Library/lib
  PATHS ${_roots}
)

# --- fmt (required by Cantera build on conda-forge) ---
find_library(FMT_LIB
  NAMES fmt fmtd
  PATH_SUFFIXES lib Library/lib
  PATHS ${_roots}
)

# --- yaml-cpp (often required) ---
find_library(YAMLCPP_LIB
  NAMES yaml-cpp yaml-cppd
  PATH_SUFFIXES lib Library/lib
  PATHS ${_roots}
)

find_library(OPENBLAS_LIB
  NAMES openblas openblas64_
  PATH_SUFFIXES lib Library/lib
  PATHS ${_roots}
)

find_library(BLAS_LIB
  NAMES blas
  PATH_SUFFIXES lib Library/lib
  PATHS ${_roots}
)

find_library(LAPACK_LIB
  NAMES lapack
  PATH_SUFFIXES lib Library/lib
  PATHS ${_roots}
)

find_library(SUNDIALS_CORE_LIB
  NAMES sundials_core
  PATH_SUFFIXES lib Library/lib
  PATHS ${_roots}
)


# --- SUNDIALS libraries (needed on Windows) ---
# Try common conda-forge names. If yours differ, we’ll adjust after one "dir" check.
find_library(SUNDIALS_CVODE_LIB   NAMES sundials_cvode   PATH_SUFFIXES lib Library/lib PATHS ${_roots})
find_library(SUNDIALS_IDA_LIB     NAMES sundials_ida     PATH_SUFFIXES lib Library/lib PATHS ${_roots})
find_library(SUNDIALS_NVECSERIAL  NAMES sundials_nvecserial PATH_SUFFIXES lib Library/lib PATHS ${_roots})
find_library(SUNDIALS_SUNLINSOLSPGMR NAMES sundials_sunlinsolspgmr PATH_SUFFIXES lib Library/lib PATHS ${_roots})
find_library(SUNDIALS_SUNLINSOLDENSE NAMES sundials_sunlinsoldense PATH_SUFFIXES lib Library/lib PATHS ${_roots})
find_library(SUNDIALS_SUNLINSOLBAND  NAMES sundials_sunlinsolband  PATH_SUFFIXES lib Library/lib PATHS ${_roots})
find_library(SUNDIALS_SUNMATRIXDENSE NAMES sundials_sunmatrixdense PATH_SUFFIXES lib Library/lib PATHS ${_roots})
find_library(SUNDIALS_SUNMATRIXBAND  NAMES sundials_sunmatrixband  PATH_SUFFIXES lib Library/lib PATHS ${_roots})

 find_library(SUNDIALS_CVODES_LIB  NAMES sundials_cvodes  PATH_SUFFIXES lib Library/lib PATHS ${_roots})
find_library(SUNDIALS_IDAS_LIB    NAMES sundials_idas    PATH_SUFFIXES lib Library/lib PATHS ${_roots})

find_library(SUNDIALS_SUNLINSOLLAPACKDENSE NAMES sundials_sunlinsollapackdense PATH_SUFFIXES lib Library/lib PATHS ${_roots})
find_library(SUNDIALS_SUNLINSOLLAPACKBAND  NAMES sundials_sunlinsollapackband  PATH_SUFFIXES lib Library/lib PATHS ${_roots})


find_package_handle_standard_args(Cantera
  REQUIRED_VARS Cantera_INCLUDE_DIR Cantera_LIBRARY
)

if(Cantera_FOUND AND NOT TARGET Cantera::cantera)
  add_library(Cantera::cantera UNKNOWN IMPORTED)
  set_target_properties(Cantera::cantera PROPERTIES
    IMPORTED_LOCATION "${Cantera_LIBRARY}"
    INTERFACE_INCLUDE_DIRECTORIES "${Cantera_INCLUDE_DIR}"
  )

# Link deps if found (Windows conda typically has them)
set(_cantera_deps "")

foreach(lib
    SUNDIALS_CORE_LIB
    SUNDIALS_NVECSERIAL
    SUNDIALS_SUNMATRIXDENSE
    SUNDIALS_SUNMATRIXBAND
    SUNDIALS_SUNLINSOLSPGMR
    SUNDIALS_SUNLINSOLDENSE
    SUNDIALS_SUNLINSOLBAND
    SUNDIALS_SUNLINSOLLAPACKDENSE
    SUNDIALS_SUNLINSOLLAPACKBAND
    SUNDIALS_CVODE_LIB
    SUNDIALS_CVODES_LIB
    SUNDIALS_IDA_LIB
    SUNDIALS_IDAS_LIB
)
 
  if(${lib})
    list(APPEND _cantera_deps "${${lib}}")
  endif()
endforeach()

if(FMT_LIB)
  list(APPEND _cantera_deps "${FMT_LIB}")
else()
  message(WARNING "fmt library not found; you may get unresolved fmt symbols.")
endif()

if(YAMLCPP_LIB)
  list(APPEND _cantera_deps "${YAMLCPP_LIB}")
endif()

if(OPENBLAS_LIB)
  list(APPEND _cantera_deps "${OPENBLAS_LIB}")
else()
  if(BLAS_LIB)   
    list(APPEND _cantera_deps "${BLAS_LIB}")   
  endif()
  if(LAPACK_LIB) 
    list(APPEND _cantera_deps "${LAPACK_LIB}") 
  endif()
endif()

if(SUNDIALS_CORE_LIB)
  list(APPEND _cantera_deps "${SUNDIALS_CORE_LIB}")
endif()

if(_cantera_deps)
  set_property(TARGET Cantera::cantera APPEND PROPERTY
      INTERFACE_LINK_LIBRARIES "${_cantera_deps}"
    )
  else()
    message(WARNING "SUNDIALS libs not found. You may get unresolved externals (CVODE/IDA).")
  endif()
endif()
