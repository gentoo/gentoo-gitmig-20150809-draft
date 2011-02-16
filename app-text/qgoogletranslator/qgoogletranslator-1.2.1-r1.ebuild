# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/qgoogletranslator/qgoogletranslator-1.2.1-r1.ebuild,v 1.3 2011/02/16 18:51:18 tomka Exp $
EAPI="3"
inherit cmake-utils fdo-mime

DESCRIPTION="GUI for google translate web service"
HOMEPAGE="http://code.google.com/p/qgt/"
SRC_URI="http://qgt.googlecode.com/files/${P}.tar.bz2"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RDEPEND=">=x11-libs/qt-gui-4.6"
DEPEND="${RDEPEND}"
DOCS="Changelog.txt"

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
