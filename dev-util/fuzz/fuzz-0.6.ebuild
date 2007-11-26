# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/fuzz/fuzz-0.6.ebuild,v 1.1 2007/11/26 18:32:10 robbat2 Exp $

inherit eutils

DESCRIPTION="Stress-tests programs by giving them random input."
HOMEPAGE="http://fuzz.sourceforge.net/"
DEB_P="${PN}_${PV}"
DEB_PR="7.3"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
		mirror://debian/pool/main/${PN:0:1}/${PN}/${DEB_P}-${DEB_PR}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=sys-libs/readline-4.3"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${P}.tar.gz
	cd "${S}"
	epatch "${DISTDIR}"/${DEB_P}-${DEB_PR}.diff.gz
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc NEWS README ChangeLog AUTHORS
}

