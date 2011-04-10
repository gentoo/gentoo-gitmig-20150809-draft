# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/qtfm/qtfm-4.9.ebuild,v 1.1 2011/04/10 12:58:54 ssuominen Exp $

EAPI=2
inherit eutils fdo-mime qt4-r2

DESCRIPTION="A small, lightweight file manager for desktops based on pure Qt"
HOMEPAGE="http://www.qtfm.org/"
SRC_URI="http://www.qtfm.org/${P}.tar.gz?attredirects=0 -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/qt-gui:4"
DEPEND="${RDEPEND}"

src_install() {
	dobin qtfm || die
	dodoc CHANGELOG README
	domenu qtfm.desktop
	doicon images/qtfm.png
}

pkg_postinst() { fdo-mime_desktop_database_update; }
pkg_postrm() { fdo-mime_desktop_database_update; }
