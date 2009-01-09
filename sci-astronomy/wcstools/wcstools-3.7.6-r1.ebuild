# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/wcstools/wcstools-3.7.6-r1.ebuild,v 1.2 2009/01/09 22:44:05 josejx Exp $

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
	epatch "${FILESDIR}"/${PN}-3.7.0-fix-leaks.patch
	epatch "${FILESDIR}"/${P}-autotools.patch
	sed -i -e 's/3.7.x/${PV}/' "${S}"/configure.ac || die "sed failed"
	eautoreconf
	# avoid colliding with fixdos and getdate (also in autotools patch)
	sed -i \
		-e 's/getdate/wcsgetdate/' \
		-e 's/crlf/wcscrlf/' \
		wcstools || die
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
	emake DESTDIR="${D}" install || die "emake install failed"
	doman Man/man1/* || die "doman failed"
	dodoc Readme Programs NEWS libned/NED_client || die "dodoc failed"
	newdoc libwcs/Readme Readme.libwcs || die "newdoc failed"
	newdoc libwcs/NEWS NEWS.libwcs || die "newdoc failed"
}

pkg_postinst() {
	elog "The following execs have been renamed to avoid colliding"
	elog "with other packages:"
	elog " getdate -> wcsgetdate"
	elog " crlf -> wcscrlf"
}
