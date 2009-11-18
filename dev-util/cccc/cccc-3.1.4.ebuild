# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cccc/cccc-3.1.4.ebuild,v 1.5 2009/11/18 16:25:04 vostorga Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A code counter for C and C++"
HOMEPAGE="http://cccc.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "/^CFLAGS/s|=|+=|" pccts/antlr/makefile
	sed -i -e "/^CFLAGS/s|=|+=|" pccts/dlg/makefile
	sed -i -e "/^CFLAGS/s|=|+=|" \
			-e "/^LDFLAGS/s|=|+=|" cccc/posixgcc.mak
}

src_compile() {
	emake CCC=$(tc-getCXX) LD=$(tc-getCXX) pccts || die "pccts failed"
	emake CCC=$(tc-getCXX) LD=$(tc-getCXX) cccc || die "cccc failed"
}

src_install() {
	dodoc readme.txt changes.txt || die "dodoc failed"
	dohtml cccc/*.html || die "dohtml failed"
	cd install
	dodir /usr
	emake -f install.mak INSTDIR="${D}"/usr/bin || die "install failed"
}
