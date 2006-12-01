# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/upx-ucl/upx-ucl-2.91.ebuild,v 1.1 2006/12/01 11:37:07 drizzt Exp $

inherit eutils toolchain-funcs

MY_P="${P/-ucl/}-src"
DESCRIPTION="upx is the Ultimate Packer for eXecutables."
HOMEPAGE="http://upx.sourceforge.net"
SRC_URI="http://upx.sourceforge.net/download/unstable/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

IUSE=""

DEPEND=">=dev-libs/ucl-1.02
	dev-lang/perl
	!app-arch/upx"

S="${WORKDIR}/${MY_P}"

src_compile() {
	tc-export CXX
	#make -C src UPX_UCLDIR=/usr || die "Failed compiling"
	emake all || die
}

src_install() {
	newbin src/upx.out upx

	dodoc BUGS LICENSE NEWS PROJECTS README* THANKS TODO doc/upx.doc doc/*.txt
	dohtml doc/upx.html
	doman doc/upx.1
}
