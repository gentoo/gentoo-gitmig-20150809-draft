# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/ntame/ntame-998020954.ebuild,v 1.1 2002/06/21 19:31:50 rphillips Exp $

S=${WORKDIR}/ntaim
DESCRITION="Ncurses based AOL Instant Messenger"
HOMEPAGE="http://tame.sourceforge.net/"
SRC_URI="mirror://sourceforge/tame/ntaim.${PV}.tar.gz"
DEPEND=">=sys-libs/ncurses-5.2"
SLOT="0"

src_compile () {
    
	./configure --prefix=/usr --host=${CHOST} || die
    emake || die

}

src_install () {
    
	dodir /usr/bin
    make DESTDIR=${D} install || die
	
	dodoc AUTHORS BUGS INSTALL NEWS README
}

pkg_postinst () {
	einfo "Executable name is actually ntaim"
}
