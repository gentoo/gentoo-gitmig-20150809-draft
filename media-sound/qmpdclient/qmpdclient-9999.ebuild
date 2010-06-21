# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qmpdclient/qmpdclient-9999.ebuild,v 1.2 2010/06/21 17:38:57 scarabeus Exp $

EAPI=3

inherit cmake-utils git

DESCRIPTION="QMPDClient with NBL additions, such as lyrics' display"
HOMEPAGE="http://bitcheese.net/wiki/QMPDClient"
#SRC_URI="http://dump.bitcheese.net/files/${P}.tar.bz2"
EGIT_REPO_URI="http://github.com/Voker57/qmpdclient.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="
	x11-libs/qt-gui:4[dbus]
	x11-libs/qt-xmlpatterns:4
"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

DOCS="AUTHORS README THANKSTO Changelog"

src_configure() {
	local mycmakeargs=( "-DVERSION=${PV}" )
	cmake-utils_src_configure
}
