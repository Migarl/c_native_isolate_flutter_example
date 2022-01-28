message("including libgreet lib for platform \"${CMAKE_SYSTEM_NAME}\" to sample flutter application")

add_library(libgreet SHARED IMPORTED GLOBAL)

if(${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
  set_target_properties(libgreet PROPERTIES
    IMPORTED_LOCATION "${CMAKE_CURRENT_LIST_DIR}/build/lib/libgreet.so")
elseif(${CMAKE_SYSTEM_NAME} STREQUAL "Darwin")
  set_target_properties(libgreet PROPERTIES
    IMPORTED_LOCATION "${CMAKE_CURRENT_LIST_DIR}/build/lib/libgreet.dylib")
elseif(${CMAKE_SYSTEM_NAME} STREQUAL "Windows")
  set_target_properties(libgreet PROPERTIES
    IMPORTED_LOCATION "${CMAKE_CURRENT_LIST_DIR}/build/lib/libgreet.dll")
else()
  message(FATAL_ERROR "cannot build greet library for platform ${CMAKE_SYSTEM_NAME}; no recipe defined")   
endif()

list(APPEND PLUGIN_BUNDLED_LIBRARIES
  "$<TARGET_FILE:libgreet>")