# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/wally/wally-2.0.0.ebuild,v 1.2 2009/02/25 20:56:41 hwoarang Exp $

EAPI="2"
inherit eutils qt4

DESCRIPTION="A Qt4 wallpaper changer"
HOMEPAGE="http://wally.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libexif
	 x11-libs/qt-gui:4 "
RDEPEND="${DEPEND}"

src_configure() {
	eqmake4
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"
	newicon res/images/idle.png wally.png
	make_desktop_entry wally Wally wally "Graphics;Qt"
}
