# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmwork/wmwork-0.2.5.ebuild,v 1.2 2007/08/22 06:27:43 s4t4n Exp $

inherit eutils

DESCRIPTION="Dock-app that lets you easily track time spent on different projects."
HOMEPAGE="http://www.godisch.de/debian/wmwork/"
SRC_URI="http://www.godisch.de/debian/wmwork/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND=">=x11-libs/libXext-1.0.3
	>=x11-libs/libX11-1.1.1-r1
	>=x11-libs/libXpm-3.5.6"

src_compile() {
	cd src
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dodoc README CHANGES
	cd src
	emake DESTDIR="${D}" install || die "emake install failed"
	doman wmwork.1 || die "doman failed"
}
