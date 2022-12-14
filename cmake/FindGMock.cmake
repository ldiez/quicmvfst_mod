# Copyright (c) Meta Platforms, Inc. and affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

#
# Find libgmock
#
#  LIBGMOCK_DEFINES     - List of defines when using libgmock.
#  LIBGMOCK_INCLUDE_DIR - where to find gmock/gmock.h, etc.
#  LIBGMOCK_LIBRARIES   - List of libraries when using libgmock.
#  LIBGMOCK_FOUND       - True if libgmock found.

IF (LIBGMOCK_INCLUDE_DIR)
  # Already in cache, be silent
  SET(LIBGMOCK_FIND_QUIETLY TRUE)
ENDIF ()

FIND_PATH(LIBGTEST_INCLUDE_DIR gtest/gtest.h)
FIND_PATH(LIBGMOCK_INCLUDE_DIR gmock/gmock.h)

FIND_LIBRARY(LIBGMOCK_MAIN_LIBRARY gmock_main)
FIND_LIBRARY(LIBGMOCK_LIBRARY gmock)
FIND_LIBRARY(LIBGTEST_LIBRARY gtest)
set(LIBGMOCK_LIBRARIES
  ${LIBGMOCK_MAIN_LIBRARY}
  ${LIBGMOCK_LIBRARY}
  ${LIBGTEST_LIBRARY}
)

if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
  # The GTEST_LINKED_AS_SHARED_LIBRARY macro must be set properly on Windows.
  #
  # There isn't currently an easy way to determine if a library was compiled as
  # a shared library on Windows, so just assume we've been built against a
  # shared build of gmock for now.
  SET(LIBGMOCK_DEFINES "GTEST_LINKED_AS_SHARED_LIBRARY=1" CACHE STRING "")
endif()

# handle the QUIETLY and REQUIRED arguments and set LIBGMOCK_FOUND to TRUE if
# all listed variables are TRUE
INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(
  LIBGMOCK
  DEFAULT_MSG
  LIBGMOCK_MAIN_LIBRARY
  LIBGMOCK_LIBRARY
  LIBGTEST_LIBRARY
  LIBGMOCK_LIBRARIES
  LIBGMOCK_INCLUDE_DIR
  LIBGTEST_INCLUDE_DIR
)

MARK_AS_ADVANCED(
  LIBGMOCK_DEFINES
  LIBGMOCK_MAIN_LIBRARY
  LIBGMOCK_LIBRARY
  LIBGTEST_LIBRARY
  LIBGMOCK_LIBRARIES
  LIBGMOCK_INCLUDE_DIR
)
