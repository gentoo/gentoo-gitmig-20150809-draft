# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libbluray-xine/libbluray-xine-0.2.1.ebuild,v 1.2 2012/01/03 22:46:14 ssuominen Exp $

EAPI=4

inherit toolchain-funcs

MY_P="libbluray-${PV}"
DESCRIPTION="Xine plugin for blu-ray playback libraries"
HOMEPAGE="http://www.videolan.org/developers/libbluray.html"
SRC_URI="ftp://ftp.videolan.org/pub/videolan/libbluray/${PV}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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
	!media-libs/xine-lib[bluray]
	dev-util/pkgconfig
"

DOCS=( HOWTO )

S="${WORKDIR}/${MY_P}/player_wrappers/xine"

src_prepare() {
	sed -i -e "s:-O2 ::" Makefile || die
	tc-export CC
}
