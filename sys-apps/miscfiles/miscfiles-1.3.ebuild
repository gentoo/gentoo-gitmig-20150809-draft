# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/miscfiles/miscfiles-1.3.ebuild,v 1.2 2002/08/08 14:24:52 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Miscellaneous files"
SRC_URI="ftp://ftp.gnu.org/gnu/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/directory/miscfiles.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

src_unpack() {
	unpack ${A}

	cd ${S}
	patch < ${FILESDIR}/tasks.info.diff || die
}

src_compile() {
	econf || die
	make || die
}

src_install() {
	einstall || die
	dodoc GNU* NEWS ORIGIN README dict-README
}
