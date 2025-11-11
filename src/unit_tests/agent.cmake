# Find the som shared library
find_library(SOMEXT NAMES libsomext.dylib HINTS "${SRC_FOLDER}")
if(SOMEXT)
  set(uname "Darwin")
else()
  set(uname "Linux")
endif()
find_library(SOMEXT NAMES libsomext.so HINTS "${SRC_FOLDER}")

if(NOT SOMEXT)
    message(FATAL_ERROR "libsomext not found! Aborting...")
endif()

# Add compiling flags and set tests dependencies
if(${uname} STREQUAL "Darwin")
    set(TEST_DEPS ${SOMLIB} ${SOMEXT} -lpthread -ldl -fprofile-arcs -ftest-coverage)
    add_compile_options(-ggdb -O0 -g -coverage -DTEST_AGENT -I/usr/local/include -DENABLE_SYSC -DSOM_UNIT_TESTING)
else()
    link_directories("${SRC_FOLDER}/syscheckd/build/lib/")
    add_compile_options(-ggdb -O0 -g -coverage -DTEST_AGENT -DENABLE_AUDIT -DINOTIFY_ENABLED -fsanitize=address -fsanitize=undefined)
    link_libraries(-fsanitize=address -fsanitize=undefined)
    set(TEST_DEPS ${SOMLIB} ${SOMEXT} -lpthread -lcmocka -ldl -lfimebpf -fprofile-arcs -ftest-coverage)
endif()

if(NOT ${uname} STREQUAL "Darwin")
  add_subdirectory(client-agent)
  add_subdirectory(logcollector)
  add_subdirectory(os_execd)
endif()

add_subdirectory(som_modules)
