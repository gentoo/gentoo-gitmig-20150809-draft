# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libxml/libxml-1.8.15.ebuild,v 1.3 2001/10/06 10:06:49 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="libxml"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"

RDEPEND=">=sys-libs/ncurses-5.2"

DEPEND="${RDEPEND}
        >=sys-libs/readline-4.1"


src_compile() {
	LDFLAGS="-lncurses" ./configure --host=${CHOST} 		\
	                                --prefix=/usr	 		\
				        --sysconfdir=/etc || die

	make || die # Doesn't work with -j 4 (hallski)
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING* ChangeLog NEWS README
}







