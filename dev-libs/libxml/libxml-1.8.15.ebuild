# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libxml/libxml-1.8.15.ebuild,v 1.2 2001/08/31 22:31:17 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="libxml"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"

DEPEND=">=gnome-base/gnome-env-1.0
	>=sys-libs/ncurses-5.2
        >=sys-libs/readline-4.1"

RDEPEND=">=gnome-base/gnome-env-1.0
	>=sys-libs/ncurses-5.2"

src_compile() {
	LDFLAGS="-lncurses" ./configure --host=${CHOST} 		\
	                                --prefix=/opt/gnome 		\
				        --sysconfdir=/etc/opt/gnome	\
				        --mandir=/opt/gnome/man 
	assert

	make || die # Doesn't work with -j 4 (hallski)
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING* ChangeLog NEWS README
}







