# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mboxgrep/mboxgrep-0.7.9.ebuild,v 1.4 2004/07/15 01:51:14 agriffis Exp $

DESCRIPTION="Grep for mbox files"
SRC_URI="mirror://sourceforge/mboxgrep/${P}.tar.gz"
HOMEPAGE="http://mboxgrep.sf.net"

DEPEND="virtual/libc"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE=""

src_compile() {
	econf || die "./configure failed"
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
