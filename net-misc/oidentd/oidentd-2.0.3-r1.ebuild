# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/oidentd/oidentd-2.0.3-r1.ebuild,v 1.7 2003/06/12 21:43:04 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Another (RFC1413 compliant) ident daemon"
HOMEPAGE="http://dev.ojnk.net/"
SRC_URI="mirror://sourceforge/ojnk/${P}.tar.gz"
KEYWORDS="x86 sparc "
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/glibc"

src_compile() {
	./configure --prefix=/usr --mandir=/usr/share/man || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog README TODO NEWS
	exeinto /etc/init.d ; newexe ${FILESDIR}/oidentd-2.0.3-r1-init oidentd
	insinto /etc/conf.d ; newins ${FILESDIR}/oidentd-2.0.3-r1-confd oidentd
}
