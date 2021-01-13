
#[[
find_path(REGEX_INCLUDE_DIR regextoken.h
        HINTS /usr/local/include
        PATH_SUFFIXES regextoken )

find_library(REGEX_LIBRARY NAMES regextoken.so
        HINTS /usr/local/lib)

include(FindPackageHandleStandardArgs)
# handle the QUIETLY and REQUIRED arguments and set GO_REGEX2_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(REGEX  DEFAULT_MSG
        REGEX_LIBRARY GO-REGEX_INCLUDE_DIR)

mark_as_advanced(REGEX_INCLUDE_DIR REGEX_LIBRARY )

set(GO_REGEX_LIBRARIES ${GO_REGEX_LIBRARY} )
set(GO_REGEX_INCLUDE_DIRS ${GO_REGEX_INCLUDE_DIR} )
]]

add_library(regex STATIC IMPORTED GLOBAL)
set_target_properties(regex
        PROPERTIES
        IMPORTED_LOCATION /usr/local/lib/regex/regextoken.so
        INTERFACE_INCLUDE_DIRECTORIES /usr/local/include/regex)

