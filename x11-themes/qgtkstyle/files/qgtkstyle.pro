TEMPLATE = lib
CONFIG += qt plugin link_pkgconfig

LIBS += $$QMAKE_LIBS_X11
PKGCONFIG += gdk-x11-2.0
PKGCONFIG += atk

contains(QT_CONFIG, reduce_exports):CONFIG += hide_symbols

TARGET   = $$qtLibraryTarget(gtkstyle)
HEADERS  = qgtkstyle.h \
           qgtkpainter_p.h
SOURCES  = qgtkstyle.cpp \
           qgtkpainter.cpp \

target.path = $$[QT_INSTALL_PLUGINS]/styles
INSTALLS += target

