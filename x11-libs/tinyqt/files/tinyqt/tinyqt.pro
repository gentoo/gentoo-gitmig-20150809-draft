TEMPLATE	= lib
CONFIG = console release staticlib
VERSION		= 3.0.1
DEFINES		= QT_NO_CODECS QT_LITE_UNICODE QT_NO_REMOTE QT_NO_STL
INCLUDEPATH	= $(QTDIR)/include ../tools ../kernel .
DEPENDPATH	= $(QTDIR)/include ../tools ../kernel .
LIBS		=
DESTDIR		= ../../lib
OBJECTS_DIR	= .
SOURCES		= ../tools/qbitarray.cpp	\
	../tools/qbuffer.cpp				\
	../tools/qcstring.cpp				\
	../tools/qdatastream.cpp			\
	../tools/qdatetime.cpp				\
	../tools/qdir.cpp					\
	../tools/qdir_unix.cpp				\
	../tools/qfile.cpp					\
	../tools/qfileinfo.cpp				\
	../tools/qfile_unix.cpp				\
	../tools/qgarray.cpp				\
	../tools/qgcache.cpp				\
	../tools/qgdict.cpp					\
	../tools/qglist.cpp					\
	../tools/qglobal.cpp				\
	../tools/qgvector.cpp				\
	../tools/qiodevice.cpp				\
	../tools/qmap.cpp					\
	../tools/qptrcollection.cpp			\
	../tools/qregexp.cpp				\
	../tools/qstring.cpp				\
	../tools/qstringlist.cpp			\
	../tools/qtextstream.cpp			\
	../codecs/qtextcodec.cpp			\
	../codecs/qutfcodec.cpp				\
	../xml/qdom.cpp						\
	../xml/qxml.cpp						\
	../kernel/qapplication.cpp			\
	../kernel/qevent.cpp				\
	../kernel/qguardedptr.cpp			\
	../kernel/qmetaobject.cpp			\
	../kernel/qobject.cpp				\
	../kernel/qsignal.cpp				\
	../kernel/qsignalmapper.cpp			\
	../kernel/qtimer.cpp				\
	../kernel/qurl.cpp					\
	../kernel/qurlinfo.cpp				\
	../kernel/qurloperator.cpp			\
	../kernel/qvariant.cpp

TARGET		= tinyqt
