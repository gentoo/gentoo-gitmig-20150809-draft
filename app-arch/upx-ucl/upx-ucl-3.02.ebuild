# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/upx-ucl/upx-ucl-3.02.ebuild,v 1.2 2008/05/16 09:43:44 armin76 Exp $

inherit eutils toolchain-funcs flag-o-matic

LZMA_VER=4.57
MY_P="${P/-ucl/}-src"
DESCRIPTION="upx is the Ultimate Packer for eXecutables."
HOMEPAGE="http://upx.sourceforge.net"
SRC_URI="http://upx.sourceforge.net/download/${MY_P}.tar.bz2
	mirror://sourceforge/sevenzip/lzma${LZMA_VER/.}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

IUSE=""

DEPEND=">=dev-libs/ucl-1.02
	dev-lang/perl
	!app-arch/upx"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${MY_P}.tar.bz2
	mkdir "${WORKDIR}"/lzma-${LZMA_VER}
	cd "${WORKDIR}"/lzma-${LZMA_VER}
	unpack lzma${LZMA_VER/.}.tar.bz2
}

src_compile() {
	use sparc && append-flags "-D__BIG_ENDIAN__"

	tc-export CXX
	emake UPX_LZMADIR="${WORKDIR}"/lzma-${LZMA_VER} all || die
}

src_install() {
	newbin src/upx.out upx

	dodoc BUGS LICENSE NEWS PROJECTS README* THANKS TODO doc/upx.doc doc/*.txt
	dohtml doc/upx.html
	doman doc/upx.1
}
