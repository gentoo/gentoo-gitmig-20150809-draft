# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/mutella/mutella-0.4.3.ebuild,v 1.5 2004/04/01 00:48:06 jhuebel Exp $

DESCRIPTION="Text-mode gnutella client"
SRC_URI="mirror://sourceforge/mutella/${P}.tar.gz"
HOMEPAGE="http://mutella.sourceforge.net/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~amd64"
IUSE=""
DEPEND="virtual/glibc
	sys-libs/readline"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/mutella-gcc33-fix.gz
}

src_compile() {
	econf
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING INSTALL LICENSE KNOWN-BUGS README TODO
}
