# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kio-upnp-ms/kio-upnp-ms-0.8.0_p20110313.ebuild,v 1.4 2011/04/29 14:02:46 scarabeus Exp $

EAPI=4

inherit kde4-base

DESCRIPTION="A upnp KIO slave for KDE"
HOMEPAGE="https://projects.kde.org/projects/playground/base/kio-upnp-ms"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-libs/herqq-1.0.0"
DEPEND="${RDEPEND}"

src_prepare() {
	mkdir -p "${S}/cmake/modules/" || die
	cp "${FILESDIR}"/FindHUpnp.cmake "${S}/cmake/modules/" || die
	sed -i '6 a \
set(CMAKE_MODULE_PATH \${CMAKE_MODULE_PATH} \${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules)' \
		"${S}/CMakeLists.txt" || die
	kde4-base_src_prepare
}
