TEMPLATE	= lib
CONFIG = console release staticlib
VERSION		= 3.0.2
DEFINES		= QT_NO_CODECS QT_LITE_UNICODE QT_NO_STL
INCLUDEPATH	= $(QTDIR)/include ../tools ../xml ../kernel .
DEPENDPATH	= $(QTDIR)/include ../tools ../xml ../kernel .
LIBS		=
DESTDIR		= ../../lib
OBJECTS_DIR	= .
SOURCES		=  ../tools/qbitarray.cpp	\
	../tools/qbuffer.cpp				\
    ../tools/qcstring.cpp				\
    ../tools/qdatastream.cpp			\
    ../tools/qdatetime.cpp				\
    ../tools/qdir.cpp					\
    ../tools/qdir_unix.cpp				\
    ../tools/qfile.cpp					\
    ../tools/qfile_unix.cpp				\
    ../tools/qfileinfo.cpp				\
    ../tools/qfileinfo_unix.cpp			\
    ../tools/qgarray.cpp				\
    ../tools/qgcache.cpp				\
    ../tools/qgdict.cpp					\
    ../tools/qglist.cpp					\
    ../tools/qglobal.cpp				\
	../tools/qgpluginmanager.cpp		\
    ../tools/qgvector.cpp				\
    ../tools/qiodevice.cpp				\
    ../tools/qlibrary.cpp				\
    ../tools/qlibrary_unix.cpp			\
    ../tools/qmap.cpp					\
    ../tools/qptrcollection.cpp			\
    ../tools/qregexp.cpp				\
    ../tools/qsettings.cpp				\
    ../tools/qsettings_unix.cpp			\
    ../tools/qstring.cpp				\
    ../tools/qstringlist.cpp			\
    ../tools/qtextstream.cpp			\
    ../tools/quuid.cpp					\
    ../codecs/qtextcodec.cpp			\
    ../codecs/qutfcodec.cpp				\
	../xml/qdom.cpp						\
	../xml/qxml.cpp						\
	../kernel/qurl.cpp					\
	../kernel/qurlinfo.cpp

TARGET		= tinyqt
