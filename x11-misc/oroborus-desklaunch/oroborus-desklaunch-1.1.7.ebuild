# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/oroborus-desklaunch/oroborus-desklaunch-1.1.7.ebuild,v 1.1 2010/05/31 15:45:17 xarthisius Exp $

EAPI=2

inherit eutils toolchain-funcs

MY_PN=${PN/oroborus-//}

DESCRIPTION="utility for creating desktop icons for Oroborus"
HOMEPAGE="http://www.oroborus.org"
SRC_URI="http://ftp.debian.org/debian/pool/main/d/${MY_PN}/${MY_PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm
	!x11-wm/oroborus-extras"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_PN}-${PV}

pkg_setup() {
	tc-export CC
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.diff
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README debian/changelog debian/example_rc || die
}
