# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/wcstools/wcstools-3.7.0.ebuild,v 1.1 2007/09/11 11:21:24 bicatali Exp $

inherit eutils autotools

DESCRIPTION="Astronomy Library to handle World Coordinate System for FITS images"
HOMEPAGE="http://tdc-www.harvard.edu/software/wcstools"
SRC_URI="http://tdc-www.harvard.edu/software/${PN}/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-fix-warnings.patch
	epatch "${FILESDIR}"/${P}-fix-leaks.patch
	epatch "${FILESDIR}"/${P}-autotools.patch
	sed -i -e 's/3.7.x/${PV}/' configure.ac || die "sed failed"
	eautoreconf
}

src_test() {
	cd "${S}"
	einfo "Testing various wcstools programs"
	./newfits -a 10 -j 248 41 -p 0.15 test.fits || die "test newfits failed"
	./sethead test.fits A=1 B=1 ||  die "test sethead failed"
	[[ "$(./gethead test.fits RA)" == "16:32:00.000" ]] \
		|| die "test gethead failed"
	rm -f test.fits
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	doman Man/man1/* || die "doman failed"
	dodoc Readme Programs NEWS || die "dodoc failed"
	newdoc libwcs/Readme Readme.libwcs || die "newdoc failed"
	newdoc libwcs/NEWS NEWS.libwcs || die "newdoc failed"
}
