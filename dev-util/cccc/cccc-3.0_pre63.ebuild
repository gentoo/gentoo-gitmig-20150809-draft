# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cccc/cccc-3.0_pre63.ebuild,v 1.5 2004/06/25 02:22:29 agriffis Exp $

MY_PV="${PV/0_}"
S="${WORKDIR}/${PN}-${MY_PV}"
DESCRIPTION="A code counter for C and C++."
SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_PV}.tar.gz"
HOMEPAGE="http://cccc.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""

DEPEND=""

src_compile() {
	make pccts cccc test || die
}

src_install() {
	dodoc readme.txt changes.txt
	cd install
	dodir /usr
	make -f install.mak INSTDIR="${D}/usr/bin" || die
}
