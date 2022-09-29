cmake_minimum_required(VERSION 3.16)
project(Welt)

file(GLOB_RECURSE USER_SOURCE_FILES
    src/*.cpp
)

add_executable(Welt
    ${USER_SOURCE_FILES}
)


target_include_directories(Welt PRIVATE
    src
)
