# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libdbusmenu-qt/libdbusmenu-qt-0.3.5.ebuild,v 1.2 2010/06/27 20:08:25 spatz Exp $

EAPI="3"

QT_DEPEND="4.6.0"
inherit cmake-utils

DESCRIPTION="A library providing Qt implementation of DBusMenu specification"
HOMEPAGE="http://people.canonical.com/~agateau/dbusmenu/"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.bz2"

LICENSE="LGPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug"

# Bug #315215, require X server running
RESTRICT="test"

DEPEND="
	>=x11-libs/qt-core-${QT_DEPEND}:4
	>=x11-libs/qt-gui-${QT_DEPEND}:4[dbus]
	>=x11-libs/qt-test-${QT_DEPEND}:4
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${P}-qt-4.7.patch"
)

DOCS="NEWS README"
