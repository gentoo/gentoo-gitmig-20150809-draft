# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/lua/lua-5.0.1_beta20031003-r1.ebuild,v 1.2 2004/01/03 10:22:10 avenj Exp $

DESCRIPTION="A powerful light-weight programming language designed for extending applications"
HOMEPAGE="http://www.lua.org/"
SRC_URI="http://www.lua.org/ftp/lua-5.0.tar.gz
	http://www.tecgraf.puc-rio.br/lua/work/lua-5.0-update.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~arm ~hppa ~mips ~ppc ~sparc ~x86 ~amd64"
IUSE="readline"
DEPEND=">=sys-apps/sed-4
	sys-apps/findutils"
S=${WORKDIR}/lua-5.0.1

src_unpack() {

	unpack lua-5.0.tar.gz || die
	mv lua-5.0 lua-5.0.1
	unpack lua-5.0-update.tar.gz || die

	epatch ${FILESDIR}/lua-5.0.1-pic.patch

	cd ${S}

	sed -i config \
		-e 's:^#\(LOADLIB= -DUSE_DLOPEN=1\):\1:' \
		-e 's:^#\(DLLIB= -ldl\):\1:' \
		-e 's:^#\(MYLDFLAGS= -Wl,-E\):\1:' \
		-e 's:^#\(POPEN= -DUSE_POPEN=1\)$:\1:' \
		-e "s:^\(MYCFLAGS= \)-O2:\1${CFLAGS}:" \
		-e 's:^\(INSTALL_ROOT= \)/usr/local:\1$(DESTDIR)/usr:' \
		-e 's:^\(INSTALL_MAN= $(INSTALL_ROOT)\)/man/man1:\1/share/man/man1:'

	sed -i doc/readme.html \
		-e 's:\(/README\)\("\):\1.gz\2:g'

	if [ `use readline` ]; then
		sed -i config \
			-e "s:^#\(USERCONF=-DLUA_USERCONFIG='\"\$(LUA)/etc/saconfig.c\"' -DUSE_READLINE\):\1:" \
			-e 's:^#\(EXTRA_LIBS= -lm -ldl -lreadline\) # \(-lhistory -lcurses -lncurses\):\1 \2:'
	fi

	cat >etc/lua.pc <<EOF
prefix=/usr
exec_prefix=\${prefix}
includedir=\${prefix}/include
libdir=\${exec_prefix}/lib

Name: Lua
Description: An extension programming language
Version: ${PV/_*/}
Cflags: -I\${includedir}
Libs: -L\${libdir} -llua -llualib -ldl -lm
EOF

}

src_compile() {
	export PICFLAGS=-fPIC
	emake || die "emake failed"
	emake so || die "emake so failed"
}

src_install() {

	make DESTDIR=${D} install soinstall || die "make install soinstall failed"

	dodoc COPYRIGHT HISTORY UPDATE
	dohtml doc/*.html doc/*.gif
	for i in `find . -name README -printf "%h\n"`; do
		docinto ${i#.}
		dodoc ${i}/README
	done

	insinto /usr/share/lua
	doins etc/compat.lua
	insinto /etc
	newins etc/lua.magic magic
	insinto /usr/share/pixmaps
	doins etc/lua.xpm
	insinto /usr/lib/pkgconfig
	doins etc/lua.pc

}
