# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/ion-devel/ion-devel-20031211.ebuild,v 1.2 2004/01/03 10:37:43 avenj Exp $

inherit eutils

DESCRIPTION="A tiling tabbed window manager designed with keyboard users in mind"
HOMEPAGE="http://www.iki.fi/tuomov/ion/"
SRC_URI="http://modeemi.fi/~tuomov/dl/${P}.tar.gz"
LICENSE="Clarified-Artistic"
SLOT="0"
KEYWORDS="~alpha ~arm ~hppa ~mips ~ppc ~sparc ~x86 ~amd64"
IUSE="xinerama"
DEPEND="virtual/x11
	app-misc/run-mailcap
	>=dev-lang/lua-5.0.1_beta20031003"
S=${WORKDIR}/${P/_p/-}

src_unpack() {

	unpack ${P}.tar.gz

	cat >${T}/system.mk.patch <<EOP
--- ion-devel-20031211/system.mk	2003-12-11 18:16:16.000000000 +0100
+++ ion-devel/system.mk	2003-12-17 18:05:02.000000000 +0100
@@ -7,7 +7,7 @@
 ## Installation paths
 ##
 
-PREFIX=/usr/local
+PREFIX=/usr
 
 # Unless you are creating a package conforming to some OS's standards, you
 # probably do not want to modify the following directories:
@@ -15,13 +15,13 @@
 # Main binaries
 BINDIR=\$(PREFIX)/bin
 # Configuration .lua files
-ETCDIR=\$(PREFIX)/etc/ion
+ETCDIR=/etc/X11/ion
 # Some .lua files and ion-* shell scripts
 SHAREDIR=\$(PREFIX)/share/ion
 # Manual pages
-MANDIR=\$(PREFIX)/man
+MANDIR=\$(PREFIX)/share/man
 # Some documents
-DOCDIR=\$(PREFIX)/doc/ion
+DOCDIR=\$(PREFIX)/share/doc/${PF}
 # Nothing at the moment
 INCDIR=\$(PREFIX)/include/ion
 # Nothing at the moment
@@ -68,7 +68,7 @@
 
 # If you have installed Lua 5.0 from the official tarball without changing
 # paths, this so do it.
-LUA_DIR=/usr/local
+LUA_DIR=/usr
 LUA_LIBS = -L\$(LUA_DIR)/lib -R\$(LUA_DIR)/lib -llua -llualib
 LUA_INCLUDES = -I\$(LUA_DIR)/include
 LUA=\$(LUA_DIR)/bin/lua
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
	epatch ${T}/system.mk.patch

	epatch ${FILESDIR}/${P}-miscellaneous.patch

	cd ${S}

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

	if has_version '>=sys-devel/gcc-3'; then
		einfo Enabling Lua function call optimizations
		sed -i system.mk \
			-e 's/#\(C99_SOURCE=-std=c99 -DCF_HAS_VA_COPY\)/\1/'
		eend $?
	fi

}

src_compile() {
	emake || die
}

src_install() {

	make PREFIX=${D}/usr ETCDIR=${D}/etc/X11/ion install || die

	insinto /usr/include/ion
	doins *.h *.mk mkexports.lua
	for i in de floatws ioncore ionws luaextl menu query; do
		insinto /usr/include/ion/${i}
		doins ${i}/*.h
	done
	insinto /usr/include/ion/libtu
	doins libtu/include/libtu/*

	echo -e "#!/bin/sh\n/usr/bin/ion" > ${T}/ion
	echo -e "#!/bin/sh\n/usr/bin/pwm" > ${T}/pwm
	exeinto /etc/X11/Sessions
	doexe ${T}/ion ${T}/pwm

}

pkg_postinst() {
	einfo "The configuration files have moved and some have been renamed."
	einfo "To remove stale system-wide files and update user configurations run"
	einfo "    ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config"
}

pkg_config() {

	einfo "Removing stale system-wide configuration files"
	rm -Rf ${R}/etc/X11/ion-devel ${R}/etc/X11/Sessions/ion-devel
	eend 0

	einfo "Updating user configurations..."
	for h in $(cut -d: -f6 ${R}/etc/passwd); do
		if test -d ${R}${h}/.ion-devel; then
			test -d ${R}${h}/.ion2 && break
			einfo ${h}
			cp -a ${R}${h}/.ion-devel ${R}${h}/.ion2
			for i in ${R}${h}/.ion2/ioncore*.lua; do
				sed -i ${i} -e 's/ioncore/ion/g'
				mv ${i} ${i/ioncore/ion}
			done
			rm -f ${R}${h}/.ion2/ioncore*.lua
			eend 0
		fi
	done

}
