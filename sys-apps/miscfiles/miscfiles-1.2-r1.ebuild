# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/miscfiles/miscfiles-1.2-r1.ebuild,v 1.7 2002/08/14 04:40:34 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Miscellaneous files"
SRC_URI="ftp://ftp.gnu.org/gnu/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/directory/miscfiles.html"
KEYWORDS="x86 ppc sparc sparc64"
SLOT="0"
LICENSE="GPL"

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

	dodoc GNU* NEWS ORIGIN README dict-README
}
