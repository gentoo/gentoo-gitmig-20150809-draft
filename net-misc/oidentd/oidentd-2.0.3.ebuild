# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/oidentd/oidentd-2.0.3.ebuild,v 1.2 2002/05/27 17:27:39 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Another (RFC1413 compliant) ident daemon"
HOMEPAGE="http://dev.ojnk.net/"
SRC_URI="mirror://sourceforge/ojnk/${P}.tar.gz"

DEPEND="virtual/glibc"

src_compile() {
	./configure --prefix=/usr --mandir=/usr/share/man || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog README TODO NEWS
	exeinto /etc/init.d ; newexe ${FILESDIR}/oidentd-init oidentd
}
