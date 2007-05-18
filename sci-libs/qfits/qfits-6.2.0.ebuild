# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/qfits/qfits-6.2.0.ebuild,v 1.2 2007/05/18 15:17:01 bicatali Exp $

inherit eutils

DESCRIPTION="ESO stand-alone C library offering easy access to FITS files."
HOMEPAGE="http://www.eso.org/projects/aot/qfits/"
SRC_URI="ftp://ftp.hq.eso.org/pub/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"
DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# test failed due to a switch between strcpy and strcat.
	epatch "${FILESDIR}"/${P}-ttest.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README AUTHORS
	use doc && dohtml html/*
}
