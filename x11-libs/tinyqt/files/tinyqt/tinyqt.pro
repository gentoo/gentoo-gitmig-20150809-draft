TEMPLATE	= lib
CONFIG = console release staticlib
VERSION		= 3.0.1
DEFINES		= QT_NO_CODECS QT_LITE_UNICODE QT_NO_STL
INCLUDEPATH	= $(QTDIR)/include ../tools ../xml ../kernel .
DEPENDPATH	= $(QTDIR)/include ../tools ../xml ../kernel .
LIBS		=
DESTDIR		= ../../lib
OBJECTS_DIR	= .
SOURCES		= ../tools/qbuffer.cpp	\
    ../tools/qptrcollection.cpp		\
    ../tools/qcstring.cpp			\
    ../tools/qdatastream.cpp		\
    ../tools/qdatetime.cpp			\
    ../tools/qdir.cpp				\
    ../tools/qfile.cpp				\
    ../tools/qfileinfo.cpp			\
    ../tools/qgarray.cpp			\
    ../tools/qgdict.cpp				\
    ../tools/qglist.cpp				\
    ../tools/qglobal.cpp			\
    ../tools/qgvector.cpp			\
    ../tools/qiodevice.cpp			\
    ../tools/qregexp.cpp			\
    ../tools/qstring.cpp			\
    ../tools/qstringlist.cpp		\
    ../tools/qtextstream.cpp		\
    ../tools/qbitarray.cpp			\
    ../tools/qmap.cpp				\
    ../tools/qgcache.cpp			\
    ../codecs/qtextcodec.cpp		\
    ../codecs/qutfcodec.cpp			\
    ../tools/qfile_unix.cpp			\
    ../tools/qfileinfo_unix.cpp		\
    ../tools/qdir_unix.cpp			\
	../xml/qdom.cpp					\
	../xml/qxml.cpp					\
	../kernel/qurl.cpp				\
	../kernel/qurlinfo.cpp

TARGET		= tinyqt
