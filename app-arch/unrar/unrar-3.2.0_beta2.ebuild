# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/unrar/unrar-3.2.0_beta2.ebuild,v 1.2 2003/06/17 20:35:41 gmsoft Exp $

MY_P=${PN}src
S=${WORKDIR}/${PN}
DESCRIPTION="Uncompress rar files"
SRC_URI="http://www.rarlab.com/rar/${MY_P}-${PV/_beta2/}.tar.gz"
HOMEPAGE="http://www.rarlab.com/rar_add.htm"

SLOT="0"
LICENSE="unRAR"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa"

DEPEND=""

src_compile() {
	#cp ${FILESDIR}/unrar-3.00-rartypes.hpp rartypes.hpp
	make -f makefile.unix || die
}

src_install() {
	dobin unrar
	dodoc readme.txt license.txt
}
