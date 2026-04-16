# This file controls Flutter-level build steps. It should not be edited.
cmake_minimum_required(VERSION 3.13)

set(EPHEMERAL_DIR "${CMAKE_CURRENT_SOURCE_DIR}/ephemeral")

# Configuration provided via flutter tool.
include(${EPHEMERAL_DIR}/generated_config.cmake)

# TODO: Move the rest of this into files in ephemeral. See
# https://github.com/flutter/flutter/issues/57146.
add_library(flutter INTERFACE)
add_library(flutter_wrapper_app STATIC)
add_library(flutter_wrapper_plugin STATIC)

# Add the Flutter header directory to the interface library so it can be added
# to build targets.
target_include_directories(flutter INTERFACE
  "${EPHEMERAL_DIR}/flutter_linux"
)
target_link_libraries(flutter INTERFACE "${FLUTTER_LIBRARY}.so")
target_link_libraries(flutter INTERFACE
  ${FLUTTER_LIBRARY}
  ${FLUTTER_LIBRARY}.so
)

add_dependencies(flutter_wrapper_app flutter_assemble)
add_dependencies(flutter_wrapper_plugin flutter_assemble)

target_compile_features(flutter_wrapper_app PUBLIC cxx_std_14)
target_compile_features(flutter_wrapper_plugin PUBLIC cxx_std_14)

target_sources(flutter_wrapper_app PRIVATE
  ${EPHEMERAL_DIR}/flutter_linux/fl_view.h
)
target_sources(flutter_wrapper_plugin PRIVATE
  ${EPHEMERAL_DIR}/flutter_linux/fl_view.h
)

# === Flutter tool backend ===
# These targets are invoked by the build system, and they are not suitable
# for external use.
add_custom_target(flutter_assemble VERBATIM
  COMMAND "${FLUTTER_TOOL_ENVIRONMENT}"
    "${CMAKE_SOURCE_DIR}/../flutter/packages/flutter_tools/bin/tool_backend.sh"
      linux-x64 ${CMAKE_BUILD_TYPE}
  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
)
