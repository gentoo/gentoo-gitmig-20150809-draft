# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/ntame/ntame-998020954.ebuild,v 1.5 2003/09/05 23:58:58 msterret Exp $

S=${WORKDIR}/ntaim
DESCRIPTION="Ncurses based AOL Instant Messenger"
HOMEPAGE="http://tame.sourceforge.net/"
SRC_URI="mirror://sourceforge/tame/ntaim.${PV}.tar.gz"
DEPEND=">=sys-libs/ncurses-5.2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_compile () {

	./configure --prefix=/usr --host=${CHOST} || die
	emake || die

}

src_install () {

	dodir /usr/bin
	make DESTDIR=${D} install || die

	dodoc AUTHORS BUGS NEWS README TODO
}

pkg_postinst () {
	einfo "Executable name is actually ntaim"
}
