# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kio-upnp-ms/kio-upnp-ms-0.8.0_p20110110.ebuild,v 1.2 2011/04/19 02:38:40 jmbsvicetto Exp $

EAPI="3"

inherit kde4-base

DESCRIPTION="A upnp KIO slave for KDE"
HOMEPAGE="https://projects.kde.org/projects/playground/base/kio-upnp-ms"
SRC_URI="mirror://gentoo/kio-upnp-ms-0.8.0_p20110110.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="=media-libs/herqq-0.8.0
	kde-base/kdelibs
	x11-libs/qt-core"
DEPEND="${RDEPEND}"

src_prepare() {
	cp "${FILESDIR}"/FindHUpnp.cmake "${T}" || die
	kde4-base_src_prepare || die
	mycmakeargs=( -DCMAKE_MODULE_PATH="${T}" -DHUPNP_INCLUDE_DIR="${EPREFIX}/usr/include" )
}
