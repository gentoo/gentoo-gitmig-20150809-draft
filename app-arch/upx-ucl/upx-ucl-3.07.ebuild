# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/upx-ucl/upx-ucl-3.07.ebuild,v 1.1 2011/01/06 03:15:12 vapier Exp $

EAPI="2"

inherit eutils toolchain-funcs flag-o-matic

LZMA_VER=465
#LZMA_VER=920
MY_P="${P/-ucl}-src"
DESCRIPTION="Ultimate Packer for eXecutables (free version using UCL compression and not NRV)"
HOMEPAGE="http://upx.sourceforge.net/"
SRC_URI="http://upx.sourceforge.net/download/${MY_P}.tar.bz2
	lzma? ( mirror://sourceforge/sevenzip/lzma${LZMA_VER}.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="lzma zlib"

DEPEND=">=dev-libs/ucl-1.02
	dev-lang/perl
	!app-arch/upx"

S="${WORKDIR}/${MY_P}"

src_configure() {
	use zlib && append-cppflags -DWITH_ZLIB=1
}

src_compile() {
	tc-export CXX
	emake UPX_LZMADIR="${WORKDIR}" all || die
}

src_install() {
	newbin src/upx.out upx || die
	dodoc BUGS NEWS PROJECTS README* THANKS TODO doc/*.txt
	dohtml doc/upx.html || die
	doman doc/upx.1 || die
}
