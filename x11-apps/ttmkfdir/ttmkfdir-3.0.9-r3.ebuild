# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/ttmkfdir/ttmkfdir-3.0.9-r3.ebuild,v 1.8 2008/05/09 07:33:02 dberkholz Exp $

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="A utility to create a fonts.scale file from a set of TrueType fonts"
HOMEPAGE="http://www.joerg-pommnitz.de/TrueType/xfsft.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="sys-libs/zlib
	>=media-libs/freetype-2.0.8"
DEPEND="${RDEPEND}
	>=sys-devel/flex-2.5.4a-r5
	sys-devel/libtool"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-cpp.patch
	epatch "${FILESDIR}"/${P}-zlib.patch
	epatch "${FILESDIR}"/${P}-gcc34.patch
	epatch "${FILESDIR}"/${P}-encoding.patch
	# fix pack to work with new freetype include scheme (#44119)
	epatch "${FILESDIR}"/${P}-freetype_new_includes.patch
	epatch "${FILESDIR}"/${P}-gcc43.patch  # 214138

	# Install into regular filesystem, not /usr/X11R6 hierarchy
	sed -i "s:/usr/X11R6:/usr:" README ttmkfdir.cpp
}

src_compile() {
	filter-flags -O -O? -foptimize-sibling-calls -fstack-protector
	emake \
		CXX="$(tc-getCXX)" \
		OPTFLAGS="${CXXFLAGS}" \
		DEBUG="" \
		|| die "emake failed"
}

src_install() {
	into /usr
	dobin ttmkfdir || die "doexe failed"
	dodoc README
}
