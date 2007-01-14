# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/lua/lua-5.0.3-r1.ebuild,v 1.2 2007/01/14 23:14:21 mabi Exp $

inherit eutils portability

DESCRIPTION="A powerful light-weight programming language designed for extending applications"
HOMEPAGE="http://www.lua.org/"
SRC_URI="http://www.lua.org/ftp/${P}.tar.gz"

LICENSE="MIT"
SLOT="1"
KEYWORDS="~ppc ~ppc64 ~x86"
IUSE="readline"

RDEPEND="readline? ( sys-libs/readline )
		dev-lang/lua-wrapper
		!=dev-lang/lua-5.0.3
		!=dev-lang/lua-5.0.2"
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
		-e 's:^\(INSTALL_INC= $(INSTALL_ROOT)/include\):\1/lua-5.0:' \
		-e "s:^\(INSTALL_LIB= \$(INSTALL_ROOT)/\)lib:\1$(get_libdir):" \
		-e 's:^\(INSTALL_MAN= $(INSTALL_ROOT)\)/man/man1:\1/share/man/man1:'

	sed -i -e 's/^\(install: all\) strip/\1/' Makefile

	# Version the lua binarys/lib
	sed -i src/lua/Makefile \
		-e 's:^\(T= $(BIN)/lua\):\1-5.0:' \
		-e 's:llua :llua-5.0 :' \
		-e 's:llualib:llualib-5.0:'
	sed -i src/luac/Makefile \
		-e 's:^\(T= $(BIN)/luac\):\1-5.0:' \
		-e 's:llua :llua-5.0 :' \
		-e 's:llualib:llualib-5.0:'
	sed -i -e 's:^\(T= $(LIB)/liblua\).a:\1-5.0.a:' src/Makefile
	sed -i -e 's:^\(T= $(LIB)/liblualib\).a:\1-5.0.a:' src/lib/Makefile

	[[ ${ELIBC} != *BSD ]] && sed -i -e 's:^#\(DLLIB= -ldl\):\1:' config

	use ppc-macos || sed -i -e 's:^#\(MYLDFLAGS= -Wl,-E\):\1:' config

	sed -i -e 's:\(/README\)\("\):\1.gz\2:g' doc/readme.html

	if use readline ; then
		sed -i config \
			-e "s:^#\(USERCONF=-DLUA_USERCONFIG='\"\$(LUA)/etc/saconfig.c\"' -DUSE_READLINE\):\1:" \
			-e 's:^\(EXTRA_LIBS= -lm\)$:\1 -lreadline:'
	fi

	cat >etc/lua-5.0.pc <<EOF
prefix=/usr
exec_prefix=\${prefix}
includedir=\${prefix}/include/lua-5.0
libdir=\${exec_prefix}/$(get_libdir)
interpreter=\${exec_prefix}/bin/lua-5.0
compiler=\${exec_prefix}/bin/luac-5.0

Name: Lua
Description: An extension programming language
Version: ${PV}
Cflags: -I\${includedir}
Libs: -L\${libdir} -llua-5.0 -llualib-5.0 -lm $(dlopen_lib)
EOF
}

src_compile() {
	emake || die "emake failed"
	if use ppc-macos; then
		emake dylib || die "emake dylib failed"
	else
		emake so || die "emake so failed"
	fi
	mv bin/lua-5.0 test/lua.static
	emake sobin || die "emake sobin failed"
}

src_install() {
	if use ppc-macos; then
		make DESTDIR="${D}" install dylibinstall || die "make install dylibinstall failed"
	else
		make DESTDIR="${D}" install soinstall || die "make install soinstall failed"
	fi

	dodoc HISTORY UPDATE
	dohtml doc/*.html doc/*.gif

	for i in `find . -name README -exec dirname '{}' \;`; do
		docinto ${i#.}
		dodoc ${i}/README
	done

	insinto /usr/share/lua-5.0
	doins etc/compat.lua
	insinto /usr/share/pixmaps
	newins etc/lua.xpm lua-5.0.xpm
	insinto /usr/$(get_libdir)/pkgconfig
	doins etc/lua-5.0.pc
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
