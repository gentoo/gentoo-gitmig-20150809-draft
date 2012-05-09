# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/qupzilla/qupzilla-1.2.0.ebuild,v 1.2 2012/05/09 10:22:34 ago Exp $

EAPI=4

inherit qt4-r2 vcs-snapshot

DESCRIPTION="Qt WebKit web browser"
HOMEPAGE="http://www.qupzilla.com/"
SRC_URI="https://github.com/nowrep/QupZilla/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug kde"

DEPEND="
	>=x11-libs/qt-core-4.7:4
	>=x11-libs/qt-dbus-4.7:4
	>=x11-libs/qt-gui-4.7:4
	>=x11-libs/qt-script-4.7:4
	>=x11-libs/qt-sql-4.7:4
	>=x11-libs/qt-webkit-4.7:4
"
RDEPEND="${DEPEND}"

DOCS="AUTHORS FAQ TODO"

src_configure() {
	export QUPZILLA_PREFIX="${EPREFIX}/usr/"

	if use kde; then
		KDE=true eqmake4
	else
		eqmake4
	fi
}

# TODO: translation handling
