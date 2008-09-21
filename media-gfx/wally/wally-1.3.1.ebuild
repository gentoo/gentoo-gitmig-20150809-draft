# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/wally/wally-1.3.1.ebuild,v 1.2 2008/09/21 02:53:02 yngwin Exp $

EAPI="1"
inherit eutils qt4

DESCRIPTION="A Qt4 wallpaper changer"
HOMEPAGE="http://wally.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libexif
	|| ( x11-libs/qt-gui:4 =x11-libs/qt-4.3* )"
RDEPEND="${DEPEND}"

QT4_BUILT_WITH_USE_CHECK="png"

src_compile() {
	eqmake4
	emake || die "make failed"
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"
	newicon res/images/idle.png wally.png
	make_desktop_entry wally Wally wally "Graphics;Qt"
}
