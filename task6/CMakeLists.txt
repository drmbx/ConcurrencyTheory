cmake_minimum_required(VERSION 3.28)
project(task6)

set(CMAKE_CXX_STANDARD 23)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fopenacc")

add_executable(task6 main.cpp)