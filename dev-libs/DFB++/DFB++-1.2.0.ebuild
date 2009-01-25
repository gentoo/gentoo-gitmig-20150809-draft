# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/DFB++/DFB++-1.2.0.ebuild,v 1.2 2009/01/25 17:00:24 maekke Exp $

inherit eutils

DESCRIPTION="C++ bindings for DirectFB"
HOMEPAGE="http://www.directfb.org/dfb++.xml"
SRC_URI="http://www.directfb.org/downloads/Extras/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=dev-libs/DirectFB-${PV}"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-directfb-api.patch #235041
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog NEWS README
}
