# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/ttmkfdir/ttmkfdir-3.0.9-r2.ebuild,v 1.13 2004/11/12 00:28:13 vapier Exp $

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="A utility to create a fonts.scale file from a set of TrueType fonts"
HOMEPAGE="http://www.joerg-pommnitz.de/TrueType/xfsft.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ~ppc64 s390 sparc x86"
IUSE=""

RDEPEND="virtual/libc
	sys-libs/zlib
	>=media-libs/freetype-2.0.8"
DEPEND="${RDEPEND}
	>=sys-devel/flex-2.5.4a-r5
	sys-devel/libtool"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-cpp.patch
	epatch ${FILESDIR}/${P}-zlib.patch
	epatch ${FILESDIR}/${P}-gcc34.patch
	epatch ${FILESDIR}/${P}-encoding.patch
}

src_compile() {
	filter-flags -O -O? -foptimize-sibling-calls
	emake \
		CXX="$(tc-getCXX)" \
		OPTFLAGS="${CFLAGS}" \
		DEBUG="" \
		|| die "emake failed"
}

src_install() {
	exeinto /usr/X11R6/bin
	doexe ttmkfdir || die "doexe failed"
	dodoc README
}
