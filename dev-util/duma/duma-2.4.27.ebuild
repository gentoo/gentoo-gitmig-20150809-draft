# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/duma/duma-2.4.27.ebuild,v 1.1 2007/04/03 05:57:40 nerdboy Exp $

inherit eutils versionator multilib toolchain-funcs
# flag-o-matic

MY_P="${PN}_$(replace_all_version_separators '_')"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="DUMA (Detect Unintended Memory Access) is a memory debugging library."
HOMEPAGE="http://duma.sourceforge.net/"

SRC_URI="mirror://sourceforge/duma/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

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
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-types.patch"
	epatch "${FILESDIR}/${P}-make.patch"
	# source has carriage returns scattered throughout...
	#edos2unix *
}

src_compile(){
	# filter parallel make, because it generate header and that header needed
	# for next part of compile
	use amd64 && export DUMA_ALIGNMENT=16
	# append-flags doesn't work here (stupid static makefile)
	emake CFLAGS="${DUMA_OPTIONS} ${CFLAGS}" CC=$(tc-getCC) \
	    || die "emake failed"
}

src_test() {
	einfo "Control-C now if you want to disable tests..."
	epause 5

	cd ${S}
	use amd64 && export DUMA_ALIGNMENT=16
	make CFLAGS="${DUMA_OPTIONS} ${CFLAGS}" \
	    CC=$(tc-getCC) check || die "make check failed"

	einfo "Check output above to verify all tests have passed..."
}

src_install(){
	make prefix="${D}usr" LIB_INSTALL_DIR="${D}usr/$(get_libdir)" install \
	    || die "make install failed"
	insinto /usr/include
	doins duma.h duma_config.h duma_hlp.h dumapp.h noduma.h paging.h print.h \
	    sem_inc.h || die " failed install headers"
	dodoc CHANGELOG README
}

