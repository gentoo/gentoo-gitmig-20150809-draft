# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/kcmgrunlevel/kcmgrunlevel-0.2.ebuild,v 1.1 2005/02/01 20:51:35 centic Exp $

inherit kde
need-kde 3

DESCRIPTION="A runlevel/initscript editor for the KDE-3.x Controlcenter"
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=11911"
SRC_URI="http://spookyk.dyndns.org/~sarah/content/download/development/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""
SLOT="0"

src_install() {
	einstall
	insinto ${KDEDIR}/share/icons/hicolor/16x16/apps/
	doins ${S}/src/icons/hicolor/16x16/apps/${PN}.png
	insinto ${KDEDIR}/share/icons/hicolor/22x22/apps/
	doins ${S}/src/icons/hicolor/22x22/apps/${PN}.png
	insinto ${KDEDIR}/share/icons/hicolor/32x32/apps/
	doins ${S}/src/icons/hicolor/32x32/apps/${PN}.png
	insinto ${KDEDIR}/share/icons/hicolor/48x48/apps/
	doins ${S}/src/icons/hicolor/48x48/apps/${PN}.png
	insinto ${KDEDIR}/share/icons/hicolor/64x64/apps/
	doins ${S}/src/icons/hicolor/64x64/apps/${PN}.png
}

