# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/aspell/aspell-0.33.ebuild,v 1.3 2002/04/28 03:59:29 seemant Exp $


MY_P=${PN}-.33
S=${WORKDIR}/${MY_P}
DESCRIPTION="A spell checker replacement for ispell"
SRC_URI="http://download.sourceforge.net/aspell/${MY_P}.tar.gz"
HOMEPAGE="http://aspell.sourceforge.net"

DEPEND=">=app-text/pspell-0.12
	>=sys-libs/ncurses-5.2"

src_compile() {

	if [ "`use gpm`" ]
	then
	  myldflags="-lgpm"
	fi
	LDFLAGS=\"$myldflags\" ./configure --prefix=/usr --sysconfdir=/etc/aspell --host=${CHOST} --enable-doc-dir=/usr/share/doc/${P} || die
	make || die

}

src_install () {

	make DESTDIR=${D} install || die
	cd ${D}/usr/share/doc/${P}
	mv man-html html
	mv man-text txt
	prepalldocs
	cd ${S}
	
	dodoc README* TODO

}
