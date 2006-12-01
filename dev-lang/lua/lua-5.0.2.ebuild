# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/lua/lua-5.0.2.ebuild,v 1.23 2006/12/01 17:21:29 mabi Exp $

inherit eutils portability

DESCRIPTION="A powerful light-weight programming language designed for extending applications"
HOMEPAGE="http://www.lua.org/"
SRC_URI="http://www.lua.org/ftp/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc-macos ppc64 s390 sh sparc x86"
IUSE="readline"

DEPEND=">=sys-apps/sed-4
	sys-apps/findutils"

src_unpack() {
	unpack ${A}

	epatch ${FILESDIR}/lua-${PV}-pic.patch
	#epatch ${FILESDIR}/lua-${PV}-LDFLAGS_and_as-needed.patch
	use ppc-macos && epatch ${FILESDIR}/lua-ppc-macos-Makefile.patch

	cd ${S}

	if ! use ppc-macos; then
		sed -i config \
			-e 's:^#\(LOADLIB= -DUSE_DLOPEN=1\):\1:' \
			-e "s:^#\(DLLIB=\) -ldl:\1 $(dlopen_lib):" \
			-e 's:^#\(MYLDFLAGS= -Wl,-E\):\1:' \
			-e "s:^#\(LDFLAGS=\).*:\1 ${LDFLAGS}:" \
			-e 's:^#\(POPEN= -DUSE_POPEN=1\)$:\1:' \
			-e "s:^\(MYCFLAGS= \)-O2:\1${CFLAGS}:" \
			-e 's:^\(INSTALL_ROOT= \)/usr/local:\1$(DESTDIR)/usr:' \
			-e "s:^\(INSTALL_LIB= \$(INSTALL_ROOT)/\)lib:\1$(get_libdir):" \
			-e 's:^\(INSTALL_MAN= $(INSTALL_ROOT)\)/man/man1:\1/share/man/man1:'
	else
		sed -i config \
			-e 's:^#\(LOADLIB= -DUSE_DLOPEN=1\):\1:' \
			-e 's:^#\(DLLIB= -ldl\):\1:' \
			-e 's:^#\(POPEN= -DUSE_POPEN=1\)$:\1:' \
			-e "s:^\(MYCFLAGS= \)-O2:\1${CFLAGS}:" \
			-e 's:^\(INSTALL_ROOT= \)/usr/local:\1/usr:' \
			-e 's:^\(INSTALL_MAN= $(INSTALL_ROOT)\)/man/man1:\1/share/man/man1:'
	fi

	sed -i doc/readme.html \
		-e 's:\(/README\)\("\):\1.gz\2:g'

	if use readline ; then
		sed -i config \
			-e "s:^#\(USERCONF=-DLUA_USERCONFIG='\"\$(LUA)/etc/saconfig.c\"' -DUSE_READLINE\):\1:" \
			-e 's:^#\(EXTRA_LIBS= -lm -ldl -lreadline\) # \(-lhistory -lcurses -lncurses\):\1 \2:'
	fi

	cat >etc/lua.pc <<EOF
prefix=/usr
exec_prefix=\${prefix}
includedir=\${prefix}/include
libdir=\${exec_prefix}/$(get_libdir)
interpreter=\${exec_prefix}/bin/lua
compiler=\${exec_prefix}/bin/luac

Name: Lua
Description: An extension programming language
Version: ${PV}
Cflags: -I\${includedir}
Libs: -L\${libdir} -llua -llualib -ldl -lm
EOF
}

src_compile() {
	export PICFLAGS=-fPIC
	emake || die "emake failed"
	if use ppc-macos; then
		# OSX does not have so files.
		emake dylib dylibbin || die "emake dylib failed"
	else
		emake so || die "emake so failed"
	fi
}

src_install() {
	if use ppc-macos; then
		# OSX does not have so files.
		make DESTDIR=${D} install dylibinstall || die "make install	dylibinstall failed"
	else
		make DESTDIR=${D} install soinstall || die "make install soinstall failed"
	fi

	dodoc HISTORY UPDATE
	dohtml doc/*.html doc/*.gif

	for i in `find . -name README -exec dirname '{}' \;`; do
		docinto ${i#.}
		dodoc ${i}/README
	done

	insinto /usr/share/lua
	doins etc/compat.lua
	insinto /usr/share/pixmaps
	doins etc/lua.xpm
	insinto /usr/$(get_libdir)/pkgconfig
	doins etc/lua.pc
}
