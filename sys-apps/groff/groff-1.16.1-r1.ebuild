# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/groff/groff-1.16.1-r1.ebuild,v 1.2 2001/05/11 14:01:40 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Text formatter used for man pages"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/groff/${A}
	 ftp://prep.ai.mit.edu/gnu/groff/${A}"
HOMEPAGE="http://www.gnu.org/software/groff/groff.html"

DEPEND="virtual/glibc"

src_compile() {

	try ./configure --host=${CHOST} --prefix=/usr --mandir=/usr/share/man
	# pmake does not work !
	try make
}

src_install() {

        dodir /usr
	try make prefix=${D}/usr manroot=${D}/usr/share/man install

        dodoc NEWS PROBLEMS PROJECTS README TODO VERSION \
	      BUG-REPORT COPYING ChangeLog FDL MORE.STUFF \
	      REVISION

}


