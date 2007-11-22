# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/ming/ming-0.2a-r3.ebuild,v 1.10 2007/11/22 19:06:31 drac Exp $

inherit eutils toolchain-funcs flag-o-matic python multilib

KEYWORDS="alpha amd64 ~arm hppa ia64 ~mips ppc ppc64 ~s390 ~sh sparc x86 ~x86-fbsd"

DESCRIPTION="An Open Source library for Flash movie generation."
HOMEPAGE="http://www.opaque.net/ming/"
SRC_URI="http://www.opaque.net/ming/${P}.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="python"

RDEPEND="python? ( virtual/python )"

DEPEND="${RDEPEND}
		sys-devel/flex"

src_unpack() {
	unpack ${A}
	EPATCH_OPTS="-p0 -d${S}" epatch "${FILESDIR}/${P}-fpic.patch"
	EPATCH_OPTS="-p0 -d${S}" epatch "${FILESDIR}/${P}-gentoo.diff"
	sed -e 's,gcc -g -Wall,$(CC) $(CFLAGS),g' -i "${S}/py_ext/Makefile"
	EPATCH_OPTS="-p1 -d${S}" epatch "${FILESDIR}/${P}-linking.patch"
	EPATCH_OPTS="-p1 -d${S}" epatch "${FILESDIR}/${P}-make.patch"
}

src_compile() {
	einfo "Regenerating parser files ..."
	cd "${S}/src/actioncompiler"
	for f in *.flex ; do
		flex "${f}" || die "Failed to flex: ${f}"
	done
	append-flags -Wall

	einfo "Compiling ..."
	cd "${S}"
	emake CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS} -Wl,-soname,libming.so" \
		all \
		|| die "Failed to build libs"
	cd "${S}/util"
	emake CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		bindump hexdump listswf listfdb listmp3 listjpeg makefdb swftophp \
		|| die "Failed to build utils"
	if use python ; then
		cd "${S}/py_ext"
		python_version
		my_python="python${PYVER}"
		PYLIBDIR="/usr/$(get_libdir)/python${PYVER}"
		PYINCDIR="/usr/include/python${PYVER}"
		emake CC="$(tc-getCC)" \
			CFLAGS="${CFLAGS}" \
			LDFLAGS="${LDFLAGS}" \
			PYINCDIR="${PYINCDIR}" PYLIBDIR="${PYLIBDIR}" \
			mingcmodule.so \
			|| die "Failed to build mingcmodule.so"
	fi
}

src_install() {
	newlib.so libming.so libming.so.0.2 || die "newlib.so libming.so failed"

	insinto /usr/include
	doins ming.h mingpp.h || die "doins ming.h/mingpp.h failed"

	exeinto /usr/$(get_libdir)/ming
	doexe util/{bindump,hexdump,listswf,listfdb,listmp3,listjpeg,makefdb,swftophp} || die "doexe utils failed"

	dodoc CHANGES CREDITS README TODO
	newdoc util/README README.util
	newdoc util/TODO TODO.util

	if use python ; then
		cd "${S}/py_ext"
		python_version
		PYLIBDIR="/usr/$(get_libdir)/python${PYVER}"
		insinto "${PYLIBDIR}/site-packages"
		doins mingcmodule.so ming.py || die "Failed to install python extension"
		newdoc README README.python
		newdoc TODO TODO.python
		newdoc INSTALL INSTALL.python
		dodoc test.py shape.py
	fi
}

pkg_postinst() {
	if use python ; then
		python_version
		python_mod_compile /usr/$(get_libdir)/python${PYVER}/site-packages/ming.py
	fi
}
