# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/slirp/slirp-1.0.17.ebuild,v 1.1 2006/03/16 21:58:42 mrness Exp $

inherit eutils

MY_BASE_VERSION="1.0.16"

DESCRIPTION="Emulates a PPP or SLIP connection over a terminal"
HOMEPAGE="http://slirp.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_BASE_VERSION}.tar.gz
	mirror://sourceforge/${PN}/${PN}_${PV//./_}_patch.tar.gz"

KEYWORDS="-amd64 -ia64 -ppc64 -sparc ~x86"
SLOT="0"
LICENSE="Artistic"
IUSE=""

S="${WORKDIR}/${PN}-${MY_BASE_VERSION}"

src_unpack() {
	unpack ${A}

	cd "${S}/src"
	epatch "${WORKDIR}/fix17.patch"
}

src_compile() {
	cd src
	./configure || die "configure failed"
	make || die "make failed"
}

src_install() {
	dobin src/slirp
	cp src/slirp.man slirp.1
	doman slirp.1
	dodoc docs/* README.NEXT README ChangeLog COPYRIGHT
}
