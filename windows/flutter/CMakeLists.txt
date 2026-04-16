# This file controls Flutter-level build steps. It should not be edited.
cmake_minimum_required(VERSION 3.14)

set(EPHEMERAL_DIR "${CMAKE_CURRENT_SOURCE_DIR}/ephemeral")

# Configuration provided via flutter tool.
include(${EPHEMERAL_DIR}/generated_config.cmake)

# TODO: Move the rest of this into files in ephemeral. See
# https://github.com/flutter/flutter/issues/57146.
add_library(flutter INTERFACE)
add_library(flutter_wrapper_app STATIC)
add_library(flutter_wrapper_plugin STATIC)
add_library(flutter_wrapper_encodable INTERFACE)

# Attach the include directories.
target_include_directories(flutter INTERFACE
  "${EPHEMERAL_DIR}/"
)

# Add the wrapper headers and source files.
# TODO: Move this into a CMake function.
target_include_directories(flutter_wrapper_app PRIVATE
  "${EPHEMERAL_DIR}/cpp_client_wrapper/include"
)

target_include_directories(flutter_wrapper_plugin PRIVATE
  "${EPHEMERAL_DIR}/cpp_client_wrapper/include"
)

target_include_directories(flutter_wrapper_encodable INTERFACE
  "${EPHEMERAL_DIR}/cpp_client_wrapper/include"
)

# Add the Flutter library.
add_dependencies(flutter_wrapper_app flutter_assemble)
add_dependencies(flutter_wrapper_plugin flutter_assemble)

set(WRAPPER_ROOT "${EPHEMERAL_DIR}/cpp_client_wrapper")
set(FLUTTER_WRAPPER_APP_SOURCES
  "${WRAPPER_ROOT}/core_implementations.cc"
  "${WRAPPER_ROOT}/standard_codec.cc"
)
target_sources(flutter_wrapper_app PRIVATE ${FLUTTER_WRAPPER_APP_SOURCES})
target_sources(flutter_wrapper_plugin PRIVATE ${FLUTTER_WRAPPER_APP_SOURCES})

# === Flutter tool backend ===
# These targets are invoked by the build system, and they are not suitable
# for external use.
add_custom_target(flutter_assemble VERBATIM
  COMMAND "${FLUTTER_TOOL_ENVIRONMENT}"
    "${CMAKE_SOURCE_DIR}/../flutter/packages/flutter_tools/bin/tool_backend.bat"
      windows-x64 $<CONFIG>
  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
)
