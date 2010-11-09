# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libdbusmenu-qt/libdbusmenu-qt-0.6.4.ebuild,v 1.1 2010/11/09 15:08:55 tampakrap Exp $

EAPI="3"

QT_DEPEND="4.6.3"
inherit cmake-utils virtualx

DESCRIPTION="A library providing Qt implementation of DBusMenu specification"
HOMEPAGE="https://launchpad.net/libdbusmenu-qt/"
# We are using the git tag from the gitorious repository, as advised in
# kde-packager ml http://gitorious.org/dbusmenu/dbusmenu-qt
# SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.bz2"
SRC_URI="mirror://gentoo/libdbusmenu-qt-0.6.4.tar.bz2"

LICENSE="LGPL-2"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
SLOT="0"
IUSE="debug"

# Bug #315215, require X server running
RESTRICT="test"

RDEPEND="
	>=x11-libs/qt-core-${QT_DEPEND}:4
	>=x11-libs/qt-gui-${QT_DEPEND}:4[dbus]
"
DEPEND="${RDEPEND}
	test? (
		dev-libs/qjson
		>=x11-libs/qt-test-${QT_DEPEND}:4
	)
"

DOCS=(NEWS README)

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_build test TESTS)
	)
	cmake-utils_src_configure
}

# Still broken
#src_test() {
#	export maketype="cmake-utils_src_test"
#	virtualmake "$@"
#}
