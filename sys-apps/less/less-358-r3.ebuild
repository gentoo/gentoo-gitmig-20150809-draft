# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/less/less-358-r3.ebuild,v 1.1 2001/11/02 10:19:58 woodchip Exp $

DESCRIPTION="Excellent text file viewer"
HOMEPAGE="http://www.gnu.org/software/less/less.html"

S=${WORKDIR}/${P}
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/less/${P}.tar.gz
	ftp://ftp.gnu.org/pub/gnu/less/${P}.tar.gz"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2"

src_compile() {

	./configure \
	--host=${CHOST} --prefix=/usr || die

	emake || die
}

src_install() {

	dobin less lessecho lesskey
	exeinto /usr/bin ; doexe ${FILESDIR}/lesspipe.sh

	dodoc COPYING NEWS README LICENSE
	newman lesskey.nro lesskey.1
	newman less.nro less.1
}
