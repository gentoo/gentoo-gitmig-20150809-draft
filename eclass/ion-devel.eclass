# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/ion-devel.eclass,v 1.2 2003/12/10 11:17:40 twp Exp $

ECLASS=ion-devel
INHERITED="${INHERITED} ${ECLASS}"

save_DESCRIPTION="${DESCRIPTION}"
inherit eutils
DESCRIPTION="${save_DESCRIPTION}"

ION_DEVEL_VERSION=${ION_DEVEL_VERSION:-${PV}}

HOMEPAGE="http://www.iki.fi/tuomov/ion/"
IUSE="${IUSE} xinerama"
SRC_URI="${SRC_URI} http://modeemi.fi/~tuomov/dl/ion-devel-${ION_DEVEL_VERSION/_p/-}.tar.gz"

ion-devel-patch() {
	cat >${T}/${1}.patch
	epatch ${T}/${1}.patch
}

ion-devel-configure_20031121() {

	ion-devel-patch system.mk <<EOP
--- ion-devel-20031121/system.mk	2003-11-19 22:39:16.000000000 +0100
+++ ion-devel/system.mk	2003-11-22 01:17:23.000000000 +0100
@@ -7,7 +7,7 @@
 ## Installation paths
 ##
 
-PREFIX=/usr/local/ion-devel
+PREFIX=/usr
 
 # Unless you are creating a package conforming to some OS's standards, you
 # probably do not want to modify the following directories:
@@ -15,13 +15,13 @@
 # 'ioncore' binary and 'ion' script
 BINDIR=\$(PREFIX)/bin
 # Configuration .lua files
-ETCDIR=\$(PREFIX)/etc/ion-devel
+ETCDIR=/etc/X11/ion-devel
 # Some .lua files and ion-* shell scripts
 SHAREDIR=\$(PREFIX)/share/ion-devel
 # Manual pages
-MANDIR=\$(PREFIX)/man
+MANDIR=\$(PREFIX)/share/man
 # Some documents
-DOCDIR=\$(PREFIX)/doc/ion-devel
+DOCDIR=\$(PREFIX)/share/doc/${PF}
 # Nothing at the moment
 INCDIR=\$(PREFIX)/include/ion-devel
 # Nothing at the moment
@@ -68,9 +68,9 @@
 
 # If you have installed Lua 5.0 from the official tarball without changing
 # paths, this so do it.
-LUA_PATH=/usr/local
-LUA_LIBS = -L\$(LUA_PATH)/lib -R\$(LUA_PATH)/lib -llua -llualib
-LUA_INCLUDES = -I\$(LUA_PATH)/include
+LUA_PATH=/usr
+LUA_LIBS = -llua -llualib
+LUA_INCLUDES = 
 LUA=\$(LUA_PATH)/bin/lua
 LUAC=\$(LUA_PATH)/bin/luac
 
@@ -116,7 +116,7 @@
 # asprintf and vasprintf in the c library. (gnu libc has.)
 # If HAS_SYSTEM_ASPRINTF is not defined, an implementation
 # in sprintf_2.2/ is used.
-#HAS_SYSTEM_ASPRINTF=1
+HAS_SYSTEM_ASPRINTF=1
 
 
 ##
@@ -139,7 +139,7 @@
 # it so it is perhaps better not using anything at all.
 
 # Most systems
-#XOPEN_SOURCE=-ansi -D_XOPEN_SOURCE -D_XOPEN_SOURCE_EXTENDED
+XOPEN_SOURCE=-D_XOPEN_SOURCE -D_XOPEN_SOURCE_EXTENDED
 # sunos, (irix)
 #XOPEN_SOURCE=-ansi -D__EXTENSIONS__
 
@@ -153,8 +153,8 @@
 # following should optimize function calls to Lua a little.
 #C99_SOURCE=-std=c99 -DCF_HAS_VA_COPY
 
-CFLAGS=-g -Os \$(WARN) \$(DEFINES) \$(INCLUDES) \$(EXTRA_INCLUDES)
-LDFLAGS=-g -Os \$(LIBS) \$(EXTRA_LIBS)
+CFLAGS=${CFLAGS} \$(WARN) \$(DEFINES) \$(INCLUDES) \$(EXTRA_INCLUDES)
+LDFLAGS=${CFLAGS} \$(LIBS) \$(EXTRA_LIBS)
 
 
 ##
EOP

	ion-devel-patch clientwin <<EOP
--- ion-devel-20031121/ioncore/clientwin.c	2003-11-19 22:39:21.000000000 +0100
+++ ion-devel/ioncore/clientwin.c	2003-12-02 19:11:39.000000000 +0100
@@ -298,9 +298,9 @@
 	region_init(&(cwin->region), parent, &geom);
 	
 	get_colormaps(cwin);
-	get_winprops(cwin);
 	clientwin_get_protocols(cwin);
 	clientwin_get_set_name(cwin);
+	get_winprops(cwin);
 	clientwin_get_size_hints(cwin);
 	
 	XSelectInput(wglobal.dpy, win, cwin->event_mask);
EOP

	if [ `use xinerama` ]; then
		einfo Enabling Xinerama support
		eend 0
	else
		einfo Disabling Xinerama support
		sed -i system.mk \
			-e 's/\(XINERAMA_LIBS=-lXinerama\)/#\1/' \
			-e 's/#\(DEFINES += -DCF_NO_XINERAMA\)/\1/'
		eend $?
	fi

	if has_version '<x11-base/xfree-4.3.0'; then
		einfo Enabling Xfree\<4.3.0/Opera/UTF-8 bug workaround
		eend 0
	else
		einfo Disabling Xfree\<4.3.0/Opera/UTF-8 bug workaround
		sed -i system.mk \
			-e 's/\(DEFINES += -DCF_XFREE86_TEXTPROP_BUG_WORKAROUND\)/#\1/'
		eend $?
	fi

	# Currently disabled
	# UTF-8 support is broken
#	if [ `use ion-utf8` ]; then
#		einfo Using Xutf8* instead of Xmb* in UTF-8 locales
#		sed -i system.mk \
#			-e 's/#\(DEFINES += -DCF_DE_USE_XUTF8\)/\1/'
#		eend $?
#	fi

	if has_version '>=sys-devel/gcc-3'; then
		einfo Enabling Lua function call optimizations
		sed -i system.mk \
			-e 's/#\(C99_SOURCE=-std=c99 -DCF_HAS_VA_COPY\)/\1/'
		eend $?
	fi

}

ion-devel_src_unpack() {

	unpack ${A}

	echo ">>> Configuring ion-devel-${ION_DEVEL_VERSION}"
	ln -s ion-devel-${ION_DEVEL_VERSION/_p/-} ion-devel
	cd ion-devel
	ion-devel-configure_${ION_DEVEL_VERSION}

}

ion-devel_src_compile() {
	emake || die
}

ion-devel_src_install() {
	make PREFIX=${D}/usr ETCDIR=${D}/etc/X11/ion-devel install || die
}

EXPORT_FUNCTIONS src_unpack src_compile src_install
