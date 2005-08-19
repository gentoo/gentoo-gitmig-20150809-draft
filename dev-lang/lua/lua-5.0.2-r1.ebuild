# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/lua/lua-5.0.2-r1.ebuild,v 1.7 2005/08/19 10:19:01 twp Exp $

inherit eutils

DESCRIPTION="A powerful light-weight programming language designed for extending applications"
HOMEPAGE="http://www.lua.org/"
SRC_URI="http://www.lua.org/ftp/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 -hppa ~ia64 ~mips ~ppc ~ppc-macos ~sparc ~x86"
IUSE="readline"

DEPEND=">=sys-apps/sed-4
	sys-apps/findutils"

src_unpack() {
	unpack ${A}

	epatch ${FILESDIR}/lua-${PV}-gentoo.patch
	use ppc-macos && epatch ${FILESDIR}/lua-ppc-macos-Makefile.patch

	cd ${S}

	sed -i config \
		-e 's:^#\(LOADLIB= -DUSE_DLOPEN=1\):\1:' \
		-e 's:^#\(DLLIB= -ldl\):\1:' \
		-e 's:^#\(POPEN= -DUSE_POPEN=1\)$:\1:' \
		-e "s:^\(MYCFLAGS= \)-O2:\1${CFLAGS} -fPIC -DPIC:" \
		-e 's:^\(INSTALL_ROOT= \)/usr/local:\1$(DESTDIR)/usr:' \
		-e "s:^\(INSTALL_LIB= \$(INSTALL_ROOT)/\)lib:\1$(get_libdir):" \
		-e 's:^\(INSTALL_MAN= $(INSTALL_ROOT)\)/man/man1:\1/share/man/man1:'

	# The Darwin linker does not have the -E option.
	use ppc-macos || sed -i -e 's:^#\(MYLDFLAGS= -Wl,-E\):\1:' config

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
	emake
}

src_install() {
	if use ppc-macos; then
		# OSX does not have so files.
		make DESTDIR=${D} install dylibinstall || die
	else
		make DESTDIR=${D} install soinstall || die
	fi

	dodoc HISTORY UPDATE
	dohtml doc/*.html doc/*.gif
	for i in `find . -name README -printf "%h\n"`; do
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
