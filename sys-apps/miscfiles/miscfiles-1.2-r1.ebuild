# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/miscfiles/miscfiles-1.2-r1.ebuild,v 1.3 2002/07/14 19:20:18 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Miscellaneous files"
SRC_URI="ftp://ftp.gnu.org/gnu/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/directory/${PN}.html"
KEYWORDS="x86"
SLOT="0"
LICENSE=""

src_unpack() {
	unpack ${A}

	cd ${S}
	patch < ${FILESDIR}/tasks.info.diff || die
}

src_compile() {
	cd ${S}
	./configure --prefix=/usr \
		--target=${CHOST} || die
	make || die
}

src_install() {
	make prefix=${D}/usr \
		install || die
}
