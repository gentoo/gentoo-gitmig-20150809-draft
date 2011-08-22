# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libbluray-xine/libbluray-xine-0.0.1_pre20110210.ebuild,v 1.2 2011/08/22 09:11:35 radhermit Exp $

EAPI=4

inherit toolchain-funcs

MY_P="libbluray-${PV}"
DESCRIPTION="Xine plugin for blu-ray playback libraries"
HOMEPAGE="http://www.videolan.org/developers/libbluray.html"
SRC_URI="http://dev.gentoo.org/~radhermit/distfiles/${MY_P}.tar.bz2"

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
	dev-util/pkgconfig
"

DOCS=( HOWTO )

S="${WORKDIR}/${MY_P}/player_wrappers/xine"

src_prepare() {
	sed -i -e "s:-O2 ::" Makefile || die
	tc-export CC
}
