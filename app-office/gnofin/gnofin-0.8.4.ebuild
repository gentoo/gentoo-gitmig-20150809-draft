# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-office/gnofin/gnofin-0.8.4.ebuild,v 1.4 2001/10/07 12:26:19 hallski Exp $

S=${WORKDIR}/${P}
DESCRIPTION="a personal finance application for GNOME"
SRC_URI="ftp://gnofin.sourceforge.net/pub/gnofin/stable/source/${P}.tar.gz
	 http://download.sourceforge.net/gnofin/${P}.tar.gz"

HOMEPAGE="http://gnofin.sourceforge.net"

DEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1
	>=dev-libs/libxml-1.8.10"

src_compile() {
	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --sysconfdir=/etc					\
		    --localstatedir=/var/lib
	assert

	emake || die
}

src_install() {                               
	make prefix=${D}/usr						\
	     sysconfdir=${D}/etc					\
	     localstatedir=${D}/var/lib install || die

	dodoc AUTHORS COPYING* ChangeLog NEWS README*
}
