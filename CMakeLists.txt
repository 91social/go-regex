# Go cmake configuration
cmake_minimum_required(VERSION 3.15)
project(go-regex)
find_library(golang REQUIRED)

set(TARGET ${PROJECT_NAME})
set(GOPATH ${CMAKE_CURRENT_BINARY_DIR})

set(SRCS src/regextoken.go)
set(LIB regextoken.so)
set(HEADER regextoken.h)
#[[go build -o ./build/regextoken.so -buildmode=c-shared ./src/regextoken.go]]
add_custom_command(OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${LIB}
        DEPENDS ${SRCS}
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        COMMAND cd src && env GOPATH=${CMAKE_CURRENT_SOURCE_DIR} go get -t -v github.com/google/codesearch/index/... && cd ..
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        COMMAND env GOPATH=${CMAKE_CURRENT_SOURCE_DIR} go build -buildmode=c-shared
        -o "${CMAKE_CURRENT_SOURCE_DIR}/${LIB}" "${CMAKE_CURRENT_SOURCE_DIR}/src/regextoken.go"
        ${CMAKE_GO_FLAGS}
        COMMENT "Building target ${TARGET}")

add_custom_target(${TARGET} DEPENDS ${LIB} ${HEADER})

add_library(regex STATIC IMPORTED GLOBAL)
add_dependencies(regex ${TARGET})
set_target_properties(regex
        PROPERTIES
        IMPORTED_LOCATION ${CMAKE_CURRENT_SOURCE_DIR}/${LIB}
        INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR})

install(FILES
        regextoken.h
        regextoken.so
        DESTINATION
        /regex/
        )
