# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/gmp-ecm/gmp-ecm-6.4.3-r1.ebuild,v 1.1 2012/11/19 07:14:59 patrick Exp $

EAPI=4
DESCRIPTION="Elliptic Curve Method for Integer Factorization"
HOMEPAGE="http://ecm.gforge.inria.fr/"
SRC_URI="https://gforge.inria.fr/frs/download.php/30965/${P}.tar.gz"

inherit eutils

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/gmp"
RDEPEND="${DEPEND}"

S=${WORKDIR}/ecm-${PV}

src_install() {
	emake DESTDIR="${D}" install || die
	mkdir -p "${D}/usr/include/${PN}/"
	cp "${S}"/*.h "${D}/usr/include/${PN}" || die "Failed to copy headers" # needed by other apps like YAFU
}
