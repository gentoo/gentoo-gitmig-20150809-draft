# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Jeffry Molanus <Gila@home.nl>
# Maintainer: Matthew Kennedy <mkennedy@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/dctc/dctc-0.79.1.ebuild,v 1.1 2002/04/18 16:44:58 mkennedy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Direct Connect, almost famous file share program :-)"
SRC_URI="http://ac2i.tzo.com/dctc/${P}.tar.gz"
HOMEPAGE="http://ac2i.tzo.com/dctc"

DEPEND="virtual/glibc
	=dev-libs/glib-1.2*
	=sys-libs/db-3.2*"

src_compile() {
	./configure --prefix=/usr \
		--sysconfdir=/etc \
		--mandir=/usr/share/man \
		--host=${CHOST} || die
	emake || die
}

src_install() {
	make prefix=${D}/usr \
		bindir=${D}/usr/bin \
		sysconfdir=${D}/etc \
		datadir=${D}/usr/share/dctc \
		mandir=${D}/usr/share/man \
		install || die

	dodir /usr/share/doc/${PF}
	cp -a Documentation ${D}/usr/share/doc/${PF}/docs

	dodoc AUTHORS COPYING ChangeLog INSTALL KNOWN_BUGS NEWS README TODO
}
