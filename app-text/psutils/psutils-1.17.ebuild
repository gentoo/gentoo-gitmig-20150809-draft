# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/psutils/psutils-1.17.ebuild,v 1.25 2005/04/10 03:47:58 j4rg0n Exp $

DESCRIPTION="PostScript Utilities"
HOMEPAGE="http://www.tardis.ed.ac.uk/~ajcd/psutils"
SRC_URI="ftp://ftp.enst.fr/pub/unix/a2ps/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sparc x86 ~ppc-macos"
IUSE=""

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
	dev-lang/perl"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	sed \
		-e "s:/usr/local:\$(DESTDIR)/usr:" \
		-e "s:-DUNIX -O:-DUNIX ${CFLAGS}:" \
		${S}/Makefile.unix > ${S}/Makefile
}

src_compile() {
	make || die
}

src_install () {
	dodir /usr/{bin,share/man}
	make DESTDIR=${D} install || die
	dodoc README
}
