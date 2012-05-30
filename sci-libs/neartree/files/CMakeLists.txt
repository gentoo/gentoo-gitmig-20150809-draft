cmake_minimum_required(VERSION 2.8)
project (Neartree C)

SET (LIB_MAJOR 5)
SET (LIB_MINOR 1)
SET (LIB_RELEASE 0)

SET (_soversion ${LIB_MAJOR}.${LIB_MINOR}.${LIB_RELEASE})

include_directories ("${PROJECT_SOURCE_DIR}")

add_library(CNearTree SHARED CNearTree.c)
target_link_libraries(CNearTree CVector m)

set_target_properties(CNearTree PROPERTIES SOVERSION ${LIB_MAJOR} VERSION ${_soversion})

INSTALL(TARGETS CNearTree DESTINATION ${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR})
install(FILES CNearTree.h  rhrand.h  TNear.h  triple.h
			DESTINATION ${CMAKE_INSTALL_PREFIX}/include)
install(FILES README_NearTree.txt DESTINATION ${CMAKE_INSTALL_PREFIX}/share/doc/neartree-${LIB_MAJOR}.${LIB_MINOR}.${LIB_RELEASE})
install(FILES README_NearTree.html index.html DESTINATION ${CMAKE_INSTALL_PREFIX}/share/doc/neartree-${LIB_MAJOR}.${LIB_MINOR}.${LIB_RELEASE}/html)
