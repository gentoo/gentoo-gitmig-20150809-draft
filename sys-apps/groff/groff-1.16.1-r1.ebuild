# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/groff/groff-1.16.1-r1.ebuild,v 1.7 2002/07/14 19:20:17 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Text formatter used for man pages"
SRC_URI="ftp://prep.ai.mit.edu/gnu/groff/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/groff/groff.html"
KEYWORDS="x86"
SLOT="0"
DEPEND="virtual/glibc"
LICENSE="GPL-2"

src_compile() {
	./configure --host=${CHOST} --prefix=/usr --mandir=/usr/share/man || die
	# emake doesn't work
	make || die
}

src_install() {
	dodir /usr
	make prefix=${D}/usr manroot=${D}/usr/share/man install || die
	dodoc NEWS PROBLEMS PROJECTS README TODO VERSION BUG-REPORT COPYING ChangeLog FDL MORE.STUFF REVISION
}
