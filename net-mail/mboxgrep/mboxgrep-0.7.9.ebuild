# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mboxgrep/mboxgrep-0.7.9.ebuild,v 1.9 2012/02/05 18:10:26 armin76 Exp $

DESCRIPTION="Grep for mbox files"
SRC_URI="mirror://sourceforge/mboxgrep/${P}.tar.gz"
HOMEPAGE="http://mboxgrep.sf.net"

DEPEND=""

SLOT="0"
LICENSE="as-is"
KEYWORDS="ppc x86"
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
