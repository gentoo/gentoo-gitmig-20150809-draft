# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/wcstools/wcstools-3.6.8.ebuild,v 1.1 2007/06/05 16:35:59 bicatali Exp $

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
	# fix a segfault (adapted from fedora)
	epatch "${FILESDIR}"/${P}-imsetwcs.patch
	# autotoolization
	epatch "${FILESDIR}"/${P}-autotools.patch
	sed -i -e 's/3.6.x/${PV}/' configure.ac || die "sed failed"
	eautoreconf
}

src_test() {
	cd "${S}"
	ebegin "Testing various wcstools programs"
	./newfits -a 10 -j 248 41 test.fits || die "test newfits failed"
	./sethead test.fits A=1 B=1 ||  die "test sethead failed"
	[[ "$(./gethead test.fits RA)" == "16:32:00.000" ]] \
		|| die "test gethead failed"
	rm -f test.fits
	eend
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	doman Man/man1/*
	dodoc Readme Programs NEWS
	newdoc libwcs/Readme Readme.libwcs
	newdoc libwcs/NEWS NEWS.libwcs
}
