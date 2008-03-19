AM_CFLAGS = -fvisibility=hidden

INCLUDES = -I@PYTHON_INC@ @GLIB_CFLAGS@ @X_CFLAGS@ @XORG_SERVER_CFLAGS@

pythondir = $(libdir)/python@PYTHON_VERSION@/site-packages

python_LTLIBRARIES = ixf86configmodule.la
dist_python_DATA = xf86config.py

ixf86configmodule_la_SOURCES = pyxf86conf.h pyxf86conf.c xf86ParserExt.h xf86config_ext.c
ixf86configmodule_la_LDFLAGS = -module -shared -avoid-version
ixf86configmodule_la_LIBADD = @GOBJECT_LIBS@ -lxf86config
