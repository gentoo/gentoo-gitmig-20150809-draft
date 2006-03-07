# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/ming/ming-0.2a-r1.ebuild,v 1.4 2006/03/07 11:56:06 flameeyes Exp $

inherit eutils toolchain-funcs python

DESCRIPTION="A OpenSource library from flash movie generation"
HOMEPAGE="http://www.opaque.net/ming/"
SRC_URI="http://www.opaque.net/ming/${P}.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="python"

DEPEND="python? ( virtual/python )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-fpic.patch
	epatch ${FILESDIR}/${P}-gentoo.diff
	sed -e 's,gcc -g -Wall,$(CC) $(CFLAGS),g' -i ${S}/py_ext/Makefile
}

src_compile() {
	emake CC="$(tc-getCC) -Wall" CFLAGS="${CFLAGS}" all static || die
	cd util
	emake CC="$(tc-getCC) -Wall" CFLAGS="${CFLAGS}" bindump hexdump listswf listfdb listmp3 listjpeg makefdb swftophp || die
	if use python; then
		cd ${S}/py_ext
		python_version
		my_python="python${PYVER}"
		PYLIBDIR="/usr/$(get_libdir)/python${PYVER}"
		PYINCDIR="/usr/include/python${PYVER}"
		emake CC="$(tc-getCC) -Wall" CFLAGS="${CFLAGS}" \
			PYINCDIR="${PYINCDIR}" PYLIBDIR="${PYLIBDIR}" \
			mingcmodule.so
	fi
}

src_install() {
	dolib.so libming.so || die "lib.so"
	dolib.a libming.a || die "lib.a"
	insinto /usr/include
	doins ming.h || die "include"
	exeinto /usr/$(get_libdir)/ming
	doexe util/{bindump,hexdump,listswf,listfdb,listmp3,listjpeg,makefdb,swftophp} || die "utils"
	dodoc CHANGES CREDITS README TODO
	newdoc util/README README.util
	newdoc util/TODO TODO.util
	if use python; then
		cd ${S}/py_ext
		python_version
		PYLIBDIR="/usr/$(get_libdir)/python${PYVER}"
		insinto ${PYLIBDIR}/site-packages
		doins mingcmodule.so ming.py
		newdoc README README.python
		newdoc TODO TODO.python
		newdoc INSTALL INSTALL.python
		dodoc test.py shape.py
	fi
}
pkg_postinst() {
	if use python; then
		python_version
		python_mod_compile /usr/$(get_libdir)/python${PYVER}/site-packages/ming.py
	fi
}
