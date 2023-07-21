project(line)

find_package(
    # Qt5
	Qt6
COMPONENTS
    Quick
REQUIRED
)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)

add_executable(
    line
    main.cpp

    line.qrc
)

target_compile_features(
    line
PUBLIC
    cxx_std_14
)

target_compile_definitions(
    line
PRIVATE
    QNANO_QT_GL_INCLUDE
	QNANO_BUILD_GL_BACKENDS
    # QNANO_ENABLE_GLES3
)

target_link_libraries(
    line
PRIVATE
    qnite
    # Qt5::Quick
	Qt6::Quick
)

target_include_directories(
    line
PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
)