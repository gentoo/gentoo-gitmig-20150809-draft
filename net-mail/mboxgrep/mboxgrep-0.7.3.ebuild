# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mboxgrep/mboxgrep-0.7.3.ebuild,v 1.15 2004/07/23 14:52:49 tomk Exp $

DESCRIPTION="Grep for mbox files"
SRC_URI="mirror://sourceforge/mboxgrep/${P}.tar.gz"
HOMEPAGE="http://mboxgrep.sf.net"

DEPEND="virtual/libc"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc"
IUSE=""

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die
	dodoc ChangeLog NEWS TODO README
}
