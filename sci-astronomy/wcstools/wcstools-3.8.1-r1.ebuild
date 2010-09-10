# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/wcstools/wcstools-3.8.1-r1.ebuild,v 1.1 2010/09/10 10:25:59 xarthisius Exp $

EAPI=2
inherit eutils autotools

DESCRIPTION="World Coordinate System library for astronomical FITS images"
HOMEPAGE="http://tdc-www.harvard.edu/software/wcstools"
SRC_URI="http://tdc-www.harvard.edu/software/${PN}/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-autotools.patch \
		"${FILESDIR}"/${P}-format.patch \
		"${FILESDIR}"/${P}-implicits.patch \
		"${FILESDIR}"/${P}-invalid_free.patch \
		"${FILESDIR}"/${P}-overflows.patch

	# avoid colliding with fixdos, getdate and remap from other packages
	sed -i \
		-e 's/getdate/wcsgetdate/' \
		-e 's/crlf/wcscrlf/' \
		-e 's/remap/wcsremap/' \
		-e "s/3.7.x/${PV}/" \
		wcstools || die
	eautoreconf
}

src_test() {
	einfo "Testing various wcstools programs"
	./newfits -a 10 -j 248 41 -p 0.15 test.fits || die "test newfits failed"
	./sethead test.fits A=1 B=1 ||  die "test sethead failed"
	[[ "$(./gethead test.fits RA)" == "16:32:00.000" ]] \
		|| die "test gethead failed"
	rm -f test.fits
}

src_install() {
	emake DESTDIR="${D}" install || die
	doman Man/man1/* || die
	dodoc Readme Programs NEWS libned/NED_client || die
	newdoc libwcs/Readme Readme.libwcs || die
	newdoc libwcs/NEWS NEWS.libwcs || die
}

pkg_postinst() {
	elog "The following execs have been renamed to avoid colliding"
	elog "with other packages:"
	elog " getdate -> wcsgetdate"
	elog " crlf    -> wcscrlf"
	elog " remap   -> wcsremap"
}
