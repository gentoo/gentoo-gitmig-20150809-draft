# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/duma/duma-2.5.8.ebuild,v 1.1 2007/10/10 00:35:22 nerdboy Exp $

inherit eutils toolchain-funcs versionator

MY_P="${PN}_$(replace_all_version_separators '_')"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="DUMA (Detect Unintended Memory Access) is a memory debugging library."
HOMEPAGE="http://duma.sourceforge.net/"

SRC_URI="mirror://sourceforge/duma/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="examples"

DEPEND="virtual/libc"
RDEPEND="${DEPEND}
	app-shells/bash"

pkg_setup() {
	#DUMA_OPTIONS="-DDUMA_LIB_NO_LEAKDETECTION"
	DUMA_OPTIONS="-DDUMA_USE_FRAMENO"
	if [ -n "${DUMA_OPTIONS}" ]; then
	    ewarn ""
	    elog "Custom build options are ${DUMA_OPTIONS}."
	    ewarn ""
	else
	    ewarn ""
	    elog "Custom build options are not set!"
	    elog "See the package Makefile for more options."
	    ewarn ""
	fi
}

src_unpack(){
	unpack "${A}"
	cd "${S}"
	epatch "${FILESDIR}/${P}-soname.patch"
}

src_compile(){
	use amd64 && export DUMA_ALIGNMENT=16
	# append-flags doesn't work here (stupid static makefile) and neither
	# does distcc :(
	make CFLAGS="${DUMA_OPTIONS} ${CFLAGS}" CC=$(tc-getCC) \
	    || die "emake failed"
}

src_test() {
	ewarn "Control-C now if you want to disable tests..."
	epause 5

	cd "${S}"
	use amd64 && export DUMA_ALIGNMENT=16
	make CFLAGS="${DUMA_OPTIONS} ${CFLAGS}" \
	    CC=$(tc-getCC) check || die "make check failed"

	ewarn "Check output above to verify all tests have passed..."
}

src_install(){
	# make install fails nicely here on the first file...
	newbin duma.sh duma
	dolib.so libduma.so.0.0
	dosym libduma.so.0.0 /usr/$(get_libdir)/libduma.so.0
	dosym libduma.so.0.0 /usr/$(get_libdir)/libduma.so
	dolib.a libduma.a

	insinto /usr/include
	doins duma.h dumapp.h sem_inc.h paging.h print.h duma_hlp.h noduma.h \
	    || die "failed to install headers"

	dodoc CHANGELOG README.txt TODO
	doman duma.3

	if use examples; then
	    insinto /usr/share/doc/${P}/examples
	    doins example[1-6].cpp
	    doins example_makes/ex6/Makefile
	fi
}
