# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/groff/groff-1.17.2.ebuild,v 1.2 2002/01/01 22:35:51 azarah Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Text formatter used for man pages"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/groff/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/groff/groff.html"

DEPEND="virtual/glibc"

src_compile() {
	./configure --host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man || die
	# emake doesn't work
	make || die
}

src_install() {
	dodir /usr
	make prefix=${D}/usr \
		manroot=${D}/usr/share/man \
		install || die
	dodoc NEWS PROBLEMS PROJECTS README TODO VERSION BUG-REPORT \
		COPYING ChangeLog FDL MORE.STUFF REVISION
}
