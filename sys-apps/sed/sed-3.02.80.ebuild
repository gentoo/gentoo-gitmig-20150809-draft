# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sed/sed-3.02.80.ebuild,v 1.1 2000/08/14 21:34:33 drobbins Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Super-useful stream editor"
CATEGORY="sys-apps"
SRC_URI="ftp://alpha.gnu.org/pub/gnu/sed/${A}"

src_compile() {                           
	./configure --prefix=/usr --host=${CHOST}
	make
}

src_install() {                               
	into /usr
	doinfo doc/sed.info
	doman doc/sed.1
	dobin sed/sed
	dodoc COPYING NEWS README* THANKS TODO AUTHORS BUGS ANNOUNCE
}

