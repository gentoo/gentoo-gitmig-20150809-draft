# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kio-upnp-ms/kio-upnp-ms-0.8.0_p20110313.ebuild,v 1.1 2011/04/20 19:30:27 ottxor Exp $

EAPI="3"

inherit kde4-base

DESCRIPTION="A upnp KIO slave for KDE"
HOMEPAGE="https://projects.kde.org/projects/playground/base/kio-upnp-ms"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="=media-libs/herqq-1.0.0
	kde-base/kdelibs
	x11-libs/qt-core"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -i -e '/HUPNP_VER/s/0/1/' -e '/HUPNP_VER/s/9/0/' CMakeLists.txt || die
	cp "${FILESDIR}"/FindHUpnp.cmake "${T}" || die
	kde4-base_src_prepare || die
	mycmakeargs=( -DCMAKE_MODULE_PATH="${T}" -DHUPNP_INCLUDE_DIR="${EPREFIX}/usr/include" )
}
