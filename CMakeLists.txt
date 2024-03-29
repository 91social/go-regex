# Go cmake configuration
cmake_minimum_required(VERSION 3.15)
project(go-regex)
set(SRCS src/regextoken.go)
#[[go build -o ./build/regextoken.so -buildmode=c-shared ./src/regextoken.go]]

file(MAKE_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/libregex)
set(LIB ${CMAKE_CURRENT_SOURCE_DIR}/libregex/regextoken.so)
set(HEADER ${CMAKE_CURRENT_SOURCE_DIR}/libregex/regextoken.h)
add_custom_target(${CMAKE_PROJECT_NAME})
add_custom_command(TARGET ${CMAKE_PROJECT_NAME}
        PRE_BUILD
        BYPRODUCTS ${LIB} ${HEADER}
        DEPENDS ${SRCS}
        WORKING_DIRECTORY ${CMAKE_CURRENT_WORKING_DIRECTORY}
        COMMAND go mod init com.episilia/m/v2 && go mod tidy
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/src
        COMMAND go build -buildmode=c-shared
        -o "${LIB}" "${CMAKE_CURRENT_SOURCE_DIR}/src/regextoken.go"
        ${CMAKE_GO_FLAGS}
        COMMENT "Building target ${TARGET}")
add_library(regex STATIC IMPORTED GLOBAL)
MESSAGE(STATUS "files generated are in ${LIB} and ${HEADER}")
add_dependencies(regex ${CMAKE_PROJECT_NAME})
set_target_properties(regex
        PROPERTIES
        IMPORTED_LOCATION ${LIB}
        INTERFACE_INCLUDE_DIRECTORIES ${HEADER})
install(FILES
        ${LIB}
        DESTINATION
        /usr/local/lib/regex
        )

install(FILES
        ${HEADER}
        DESTINATION
        /usr/local/include/regex)


install(FILES
        ${CMAKE_CURRENT_SOURCE_DIR}/cmake/Findregex.cmake
        DESTINATION
        /usr/local/lib/cmake)