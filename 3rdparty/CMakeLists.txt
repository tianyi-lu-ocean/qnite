project(qnanopainter)

find_package(
    # Qt5
	Qt6
COMPONENTS
	Widgets
	OpenGL
    Quick
	OpenGLWidgets
REQUIRED
)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)

add_library(
    qnanopainter
STATIC
    qnanopainter/libqnanopainter/qnanopainter.cpp
    qnanopainter/libqnanopainter/qnanocolor.cpp
    qnanopainter/libqnanopainter/qnanolineargradient.cpp
    qnanopainter/libqnanopainter/qnanoimagepattern.cpp
    qnanopainter/libqnanopainter/qnanoimage.cpp
    qnanopainter/libqnanopainter/qnanofont.cpp
    qnanopainter/libqnanopainter/qnanoradialgradient.cpp
    qnanopainter/libqnanopainter/qnanoboxgradient.cpp
    qnanopainter/libqnanopainter/qnanowindow.cpp
    qnanopainter/libqnanopainter/private/qnanodebug.cpp
    qnanopainter/libqnanopainter/qnanoquickitem.cpp
    qnanopainter/libqnanopainter/qnanoquickitempainter.cpp
    qnanopainter/libqnanopainter/nanovg/nanovg.c
    # $<$<OR:$<BOOL:${ANDROID}>,$<BOOL:${IOS}>,$<BOOL:${WIN32}>>:qnanopainter/libqnanopainter/private/qnanobackendgles2.cpp>
    # $<$<OR:$<BOOL:${ANDROID}>,$<BOOL:${IOS}>,$<BOOL:${WIN32}>>:qnanopainter/libqnanopainter/private/qnanobackendgles3.cpp>
	$<$<OR:$<BOOL:${ANDROID}>,$<BOOL:${IOS}>>:qnanopainter/libqnanopainter/private/qnanobackendgles2.cpp>
    $<$<OR:$<BOOL:${ANDROID}>,$<BOOL:${IOS}>>:qnanopainter/libqnanopainter/private/qnanobackendgles3.cpp>
    $<$<NOT:$<BOOL:${ANDROID}>>:qnanopainter/libqnanopainter/private/qnanobackendgl2.cpp>
    $<$<NOT:$<BOOL:${ANDROID}>>:qnanopainter/libqnanopainter/private/qnanobackendgl3.cpp>
    
    qnanopainter/libqnanopainter/libqnanopainterdata.qrc
)

target_compile_features(
    qnanopainter
PUBLIC
    cxx_std_14
)

target_compile_definitions(
    qnanopainter
PRIVATE
    QNANO_QT_GL_INCLUDE
	QNANO_BUILD_GL_BACKENDS
    # QNANO_ENABLE_GLES3
)

target_link_libraries(
    qnanopainter
PRIVATE
    # Qt5::Quick
	Qt6::Widgets
	Qt6::Quick
	Qt6::OpenGL
	Qt6::OpenGLWidgets
    # $<$<BOOL:${WIN32}>:Qt5::Gui_GLESv2>
	# $<$<BOOL:${WIN32}>:GLESv2>
    $<$<NOT:$<BOOL:${WIN32}>>:GL>
)

target_include_directories(
    qnanopainter
PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/qnanopainter/libqnanopainter
)
