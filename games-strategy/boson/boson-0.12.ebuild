# Copyright 1999-2006 Gentoo Foundation and Thomas Capricelli <orzel@kde.org>
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/boson/boson-0.12.ebuild,v 1.1 2006/06/09 01:55:51 wolf31o2 Exp $

inherit eutils kde-functions toolchain-funcs

DESCRIPTION="real-time strategy game, with the feeling of Command&Conquer(tm)"
HOMEPAGE="http://boson.sourceforge.net/"
SRC_URI="mirror://sourceforge/boson/boson-all-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc -sparc ~x86"
IUSE=""

RDEPEND="virtual/opengl
	virtual/glu
		media-libs/openal"
DEPEND="${RDEPEND}
	>=dev-util/cmake-2.4.2"
need-kde 3

S=${WORKDIR}/${PN}-all-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	mkdir build

	epatch "${FILESDIR}"/${P}-gcc41.patch

	# Sandbox fix
	sed -i 's/^kde/#kde/' code/boson/data/CMakeLists.txt || die "sed failed"
}

src_compile() {
	cd build
	cmake \
		-DCMAKE_C_COMPILER=$(which $(tc-getCC)) \
		-DCMAKE_CXX_COMPILER=$(which $(tc-getCXX)) \
		-DCMAKE_BUILD_TYPE=None \
		-DCMAKE_VERBOSE_MAKEFILE=1 \
		-DCMAKE_INSTALL_PREFIX=/usr \
		-DKDEDIR=$(kde-config --prefix) \
		.. || die "cmake failed"

	emake || die "emake failed"
}

src_install() {
	dodoc code/{AUTHORS,ChangeLog,README}

	newicon code/boson/data/hi48-app-boson.png ${PN}.png

	cd build
	make DESTDIR="${D}" install || die "make install failed"
}
