# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libjwc_f/libjwc_f-1.1-r2.ebuild,v 1.4 2012/08/20 19:34:08 johu Exp $

EAPI=4

AUTOTOOLS_AUTORECONF=yes

inherit autotools-utils fortran-2

PATCH="612"

DESCRIPTION="additional fortran library for ccp4"
HOMEPAGE="http://www.ccp4.ac.uk/main.html"
SRC_URI="ftp://ftp.ccp4.ac.uk/jwc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~amd64-linux ~x86-linux ~x64-macos"
IUSE="static-libs"

RDEPEND="
	dev-libs/libjwc_c
	sci-libs/ccp4-libs
	virtual/fortran"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}"/${PATCH}-gentoo.patch )

src_prepare() {
	rm missing || die
	echo "libjwc_f_la_LIBADD = -ljwc_c -lccp4f" >> Makefile.am || die
	autotools-utils_src_prepare
}

src_install() {
	autotools-utils_src_install
	dohtml doc/*
}
