cmake_minimum_required(VERSION 2.8)
project(zip)

set (SOURCES ./src/zip.c)

add_library(zip STATIC ${SOURCES} )