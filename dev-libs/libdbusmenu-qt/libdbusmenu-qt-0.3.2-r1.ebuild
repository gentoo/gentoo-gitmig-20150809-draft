# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libdbusmenu-qt/libdbusmenu-qt-0.3.2-r1.ebuild,v 1.1 2010/04/27 13:47:48 reavertm Exp $

EAPI="3"

inherit cmake-utils

DESCRIPTION="A library providing Qt implementation of DBusMenu specification"
HOMEPAGE="http://people.canonical.com/~agateau/dbusmenu/"
SRC_URI="http://people.canonical.com/~agateau/dbusmenu/${P}.tar.bz2"

LICENSE="LGPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug"

# Bug #315215, require X server running
RESTRICT="test"

DEPEND="
	x11-libs/qt-core:4
	x11-libs/qt-gui:4[dbus]
	x11-libs/qt-test:4
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-0.3.2-cmake.patch"
)

DOCS="NEWS README"
