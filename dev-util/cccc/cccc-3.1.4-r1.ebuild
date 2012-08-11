# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cccc/cccc-3.1.4-r1.ebuild,v 1.1 2012/08/11 16:49:17 kensington Exp $

EAPI=4

inherit eutils toolchain-funcs

DESCRIPTION="A code counter for C and C++"
HOMEPAGE="http://cccc.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

DEPEND="dev-util/pccts"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc-4.7.patch
	epatch "${FILESDIR}"/${P}-unbundle-pccts.patch

	sed -i cccc/posixgcc.mak \
		-e "s/^CFLAGS=/CFLAGS+=/" \
		-e "/^LD_OFLAG/s|-o|-o |" \
		-e "s/^LDFLAGS=/LDFLAGS+=/" cccc/posixgcc.mak || die
	#LD_OFLAG: ld on Darwin needs a space after -o
}

src_compile() {
	emake -j1 CCC=$(tc-getCXX) LD=$(tc-getCXX) cccc
}

src_install() {
	dodoc readme.txt changes.txt
	dohtml cccc/*.html
	emake -C install -f install.mak INSTDIR="${ED}"/usr/bin
}
