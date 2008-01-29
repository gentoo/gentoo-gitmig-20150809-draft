# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/lua/lua-5.0.3.ebuild,v 1.8 2008/01/29 21:24:44 grobian Exp $

inherit eutils portability

DESCRIPTION="A powerful light-weight programming language designed for extending applications"
HOMEPAGE="http://www.lua.org/"
SRC_URI="http://www.lua.org/ftp/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="readline"

RDEPEND="readline? ( sys-libs/readline )"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-destdir.patch
	epatch "${FILESDIR}"/${P}-dylib.patch
	epatch "${FILESDIR}"/${P}-shared.patch
	epatch "${FILESDIR}"/${P}-ldflags.patch
	epatch "${FILESDIR}"/${P}-asneeded.patch

	sed -i config \
		-e 's:^#\(LOADLIB= -DUSE_DLOPEN=1\):\1:' \
		-e 's:^#\(POPEN= -DUSE_POPEN=1\)$:\1:' \
		-e "s:^\(MYCFLAGS= \)-O2:\1${CFLAGS}:" \
		-e 's:^\(INSTALL_ROOT= \)/usr/local:\1/usr:' \
		-e "s:^\(INSTALL_LIB= \$(INSTALL_ROOT)/\)lib:\1$(get_libdir):" \
		-e 's:^\(INSTALL_MAN= $(INSTALL_ROOT)\)/man/man1:\1/share/man/man1:'

	sed -i -e 's/^\(install: all\) strip/\1/' Makefile

	[[ ${ELIBC} != *BSD ]] && sed -i -e 's:^#\(DLLIB= -ldl\):\1:' config

	sed -i -e 's:\(/README\)\("\):\1.gz\2:g' doc/readme.html

	if use readline ; then
		sed -i config \
			-e "s:^#\(USERCONF=-DLUA_USERCONFIG='\"\$(LUA)/etc/saconfig.c\"' -DUSE_READLINE\):\1:" \
			-e 's:^\(EXTRA_LIBS= -lm\)$:\1 -lreadline:'
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
Libs: -L\${libdir} -llua -llualib -lm $(dlopen_lib)
EOF
}

src_compile() {
	emake || die "emake failed"
	emake so || die "emake so failed"
	mv bin/lua test/lua.static
	emake sobin || die "emake sobin failed"
}

src_install() {
	make DESTDIR="${D}" install soinstall || die "make install soinstall failed"

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

src_test() {
	local positive="bisect cf echo env factorial fib fibfor hello printf sieve sort trace-calls"
	local negative="readonly undefined"
	local test

	for test in ${positive}; do
		test/lua.static test/${test}.lua || die "test $test failed"
	done

	for test in ${negative}; do
		test/lua.static test/${test}.lua && die "test $test failed"
	done
}
