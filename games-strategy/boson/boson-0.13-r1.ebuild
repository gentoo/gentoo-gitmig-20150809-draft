# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/boson/boson-0.13-r1.ebuild,v 1.5 2009/04/20 20:05:33 maekke Exp $

inherit eutils flag-o-matic kde-functions multilib cmake-utils

MY_P=${PN}-all-${PV}
DESCRIPTION="real-time strategy game, with the feeling of Command&Conquer(tm)"
HOMEPAGE="http://boson.sourceforge.net/"
SRC_URI="mirror://sourceforge/boson/${MY_P}.tar.bz2
	mirror://gentoo/${P}-patches.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

RDEPEND="virtual/opengl
	virtual/glu
	media-libs/openal"
DEPEND="${RDEPEND}
	>=dev-util/cmake-2.4.6-r1"

need-kde 3

S=${WORKDIR}/${MY_P}

DOCS="code/AUTHORS code/ChangeLog code/README"

src_unpack() {
	unpack ${A}
	cd "${S}"
	EPATCH_SOURCE="${WORKDIR}/${P}-patches"
	EPATCH_SUFFIX="patch"
	epatch
	#Let's be multilib-strict. We likez ze discipline :-)
	sed -r -i \
		-e "s/(KDE3_LIB_INSTALL_DIR )\/lib/\1\/$(get_libdir)/" \
		{data,code,music}/CMakeLists.txt

}

src_compile() {
	append-flags -fno-strict-aliasing
	cmake-utils_src_compile
}
