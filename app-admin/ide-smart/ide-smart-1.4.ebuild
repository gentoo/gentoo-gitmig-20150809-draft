# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# Author: Thilo Bangert <bangert@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.3 2002/02/04 15:46:51 gbevin Exp

S=${WORKDIR}/${P}
DESCRIPTION="A tool to read SMART (or S.M.A.R.T) information from harddiscs."

SRC_URI="http://lightside.eresmas.com/${P}.tar.gz"
HOMEPAGE="http://lightside.eresmas.com/"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A} ; cd ${S}
	mv Makefile Makefile.orig
	rm ide-smart ide-smart.o
	sed -e "s:^CFLAGS.*:CFLAGS = ${CFLAGS}:" \
		-e "s:^#CC.*:CC = gcc:" \
		Makefile.orig > Makefile
}

src_compile() {

	emake || die

}

src_install () {

	dobin ide-smart
	doman ide-smart.8
	dodoc README COPYING

}
