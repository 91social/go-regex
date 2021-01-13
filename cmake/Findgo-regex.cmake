
find_path(GO-REGEX_INCLUDE_DIR regextoken.h
        HINTS /usr/local/include
        PATH_SUFFIXES regextoken )

find_library(GO-REGEX_LIBRARY NAMES regextoken
        HINTS /usr/local/lib regextoken.so )

include(FindPackageHandleStandardArgs)
# handle the QUIETLY and REQUIRED arguments and set GO_REGEX2_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(GO-REGEX  DEFAULT_MSG
        GO_REGEX_LIBRARY GO_REGEX_INCLUDE_DIR)

mark_as_advanced(GO-REGEX_INCLUDE_DIR GO-REGEX_LIBRARY )

set(GO_REGEX_LIBRARIES ${GO_REGEX_LIBRARY} )
set(GO_REGEX_INCLUDE_DIRS ${GO_REGEX_INCLUDE_DIR} )
