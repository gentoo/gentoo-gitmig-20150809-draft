# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/qpdfview/qpdfview-0.3.1_p427.ebuild,v 1.2 2012/07/14 13:31:17 yngwin Exp $

EAPI=4
inherit qt4-r2

DESCRIPTION="A tabbed PDF viewer using the poppler library"
HOMEPAGE="http://launchpad.net/qpdfview"
SRC_URI="http://dev.gentoo.org/~yngwin/distfiles/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cups dbus svg"

RDEPEND="app-text/poppler[qt4]
	x11-libs/qt-core:4[iconv]
	x11-libs/qt-gui:4
	cups? ( net-print/cups )
	dbus? ( x11-libs/qt-dbus:4 )
	svg? ( x11-libs/qt-svg:4 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS="CONTRIBUTORS README TODO"

src_configure() {
	local config i
	for i in cups dbus svg ; do
		if ! use ${i} ; then
			config+=" without_${i}"
		fi
	done

	eqmake4 CONFIG+="${config}"
}
