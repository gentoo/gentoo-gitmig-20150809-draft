# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/ide-smart/ide-smart-1.4.ebuild,v 1.8 2002/08/16 02:21:27 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A tool to read SMART (or S.M.A.R.T) information from harddiscs."
SRC_URI="http://lightside.eresmas.com/${P}.tar.gz"
HOMEPAGE="http://lightside.eresmas.com/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="virtual/glibc"
RDEPEND="${DEPEND}"

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
