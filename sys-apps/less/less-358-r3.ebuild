# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/less/less-358-r3.ebuild,v 1.3 2001/11/24 18:36:40 drobbins Exp $

DESCRIPTION="Excellent text file viewer"
HOMEPAGE="http://www.gnu.org/software/less/less.html"

S=${WORKDIR}/${P}
SRC_URI="ftp://ftp.gnu.org/pub/gnu/less/${P}.tar.gz"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2"

src_compile() {

	./configure \
	--host=${CHOST} --prefix=/usr || die

	make || die
}

src_install() {

	dobin less lessecho lesskey
	exeinto /usr/bin ; doexe ${FILESDIR}/lesspipe.sh

	dodoc COPYING NEWS README LICENSE
	newman lesskey.nro lesskey.1
	newman less.nro less.1
}
