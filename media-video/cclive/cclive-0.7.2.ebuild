# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/cclive/cclive-0.7.2.ebuild,v 1.3 2011/03/27 18:49:18 xarthisius Exp $

EAPI=2
CMAKE_MIN_VERSION="2.8.3"

inherit versionator cmake-utils

DESCRIPTION="Command line tool for extracting videos from various websites"
HOMEPAGE="http://cclive.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/$(get_version_component_range 1-2)/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 ~x86"
IUSE=""

RDEPEND=">=media-libs/quvi-0.2.10
	>=dev-libs/boost-1.42
	>=net-misc/curl-7.20
	>=dev-libs/libpcre-8.02[cxx]"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="ChangeLog* NEWS README"
