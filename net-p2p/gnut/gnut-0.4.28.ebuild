# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gnut/gnut-0.4.28.ebuild,v 1.4 2002/07/17 02:25:20 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Text-mode gnutella client"
SRC_URI="http://www.gnutelliums.com/linux_unix/gnut/tars/gnut-0.4.28.tar.gz"
HOMEPAGE="http://http://www.gnutelliums.com/linux_unix/gnut/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="virtual/glibc"
RDEPEND="$DEPEND"

src_compile() {
	cat /dev/null | ./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dohtml doc/*.html
	dodoc 	doc/TUTORIAL AUTHORS COPYING ChangeLog GDJ HACKING \
		INSTALL NEWS README TODO
}
