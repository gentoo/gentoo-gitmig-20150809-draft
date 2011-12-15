# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libbluray-xine/libbluray-xine-0.0.1_pre20110819.ebuild,v 1.3 2011/12/15 23:15:15 ago Exp $

EAPI=4

inherit toolchain-funcs

MY_P="libbluray-${PV}"
DESCRIPTION="Xine plugin for blu-ray playback libraries"
HOMEPAGE="http://www.videolan.org/developers/libbluray.html"
SRC_URI="mirror://gentoo/${MY_P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

COMMON_DEPEND="
	~media-libs/libbluray-${PV}
	media-libs/xine-lib
"
RDEPEND="
	${COMMON_DEPEND}
"
DEPEND="
	${COMMON_DEPEND}
	dev-util/pkgconfig
"

DOCS=( HOWTO )

S="${WORKDIR}/${MY_P}/player_wrappers/xine"

src_prepare() {
	sed -i -e "s:-O2 ::" Makefile || die
	tc-export CC
}
