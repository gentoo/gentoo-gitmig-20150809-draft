# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/groff/groff-1.18.ebuild,v 1.3 2002/08/14 04:40:34 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Text formatter used for man pages"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/groff/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/groff/groff.html"
KEYWORDS="x86 ppc sparc sparc64"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc
	media-libs/netpbm"

src_compile() {
	./configure --host=${CHOST} --prefix=/usr --mandir=/usr/share/man || die
	# emake doesn't work
	make || die
}

src_install() {
	dodir /usr
	make prefix=${D}/usr manroot=${D}/usr/share/man install || die
	cd ${D}/usr/bin
	#the following links are required for xman
	ln -s eqn geqn
	ln -s tbl gtbl
	ln -s soelim zsoelim
	dodoc NEWS PROBLEMS PROJECTS README TODO VERSION BUG-REPORT \
		COPYING ChangeLog FDL MORE.STUFF REVISION
}
