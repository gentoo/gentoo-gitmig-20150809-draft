# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cccc/cccc-3.0_pre63.ebuild,v 1.4 2004/03/13 01:49:46 mr_bones_ Exp $

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
