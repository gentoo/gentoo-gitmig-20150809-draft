# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/qupzilla/qupzilla-1.2.0.ebuild,v 1.4 2012/06/12 15:45:00 kensington Exp $

EAPI=4

inherit multilib qt4-r2 vcs-snapshot

DESCRIPTION="Qt WebKit web browser"
HOMEPAGE="http://www.qupzilla.com/"
SRC_URI="https://github.com/QupZilla/qupzilla/tarball/v${PV} -> ${P}.tar.gz"

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
	export USE_LIBPATH="${QUPZILLA_PREFIX}$(get_libdir)"

	if use kde; then
		KDE=true eqmake4
	else
		eqmake4
	fi
}

# TODO: translation handling
