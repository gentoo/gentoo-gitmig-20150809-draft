# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Matthew Kennedy <mbkennedy@ieee.com>
# $Header: /var/cvsroot/gentoo-x86/net-misc/gyach/gyach-0.7.5.ebuild,v 1.2 2002/05/23 06:50:17 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GTK+-based Yahoo! chat client"
SRC_URI="http://www4.infi.net/~cpinkham/gyach/code/${P}.tar.gz"
HOMEPAGE="http://www4.infi.net/~cpinkham/gyach/"

DEPEND="=x11-libs/gtk+-1.2*"

src_compile() {
	./configure --host=${CHOST} --prefix=/usr || die
	emake || die
}

src_install() {
  	make prefix=${D}/usr install || die
	dodoc AUTHORS BUGS COPYING ChangeLog NEWS README* TODO
}
