# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/psutils/psutils-1.17.ebuild,v 1.10 2003/02/13 09:43:32 vapier Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Post Script Utilities"
SRC_URI="ftp://ftp.enst.fr/pub/unix/a2ps/${P}.tar.gz"
HOMEPAGE="http://www.tardis.ed.ac.uk/~ajcd/psutils"
KEYWORDS="x86 ppc sparc "
SLOT="0"
LICENSE="as-is"

DEPEND="virtual/glibc sys-devel/perl"
RDEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	sed -e "s:/usr/local:\$(DESTDIR)/usr:" \
	-e "s:-DUNIX -O:-DUNIX ${CFLAGS}:" ${S}/Makefile.unix > ${S}/Makefile
}

src_compile() {

	make || die

}

src_install () {
	dodir /usr/{bin,share/man}
	make DESTDIR=${D} install || die
	dodoc README LICENSE
}
