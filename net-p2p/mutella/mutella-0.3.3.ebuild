# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/mutella/mutella-0.3.3.ebuild,v 1.7 2003/02/13 15:21:24 vapier Exp $

DESCRIPTION="Text-mode gnutella client"
SRC_URI="mirror://sourceforge/mutella/${P}.tar.gz"
HOMEPAGE="http://mutella.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND="virtual/glibc
	sys-libs/readline"

src_unpack() {
	unpack ${A}
	cd ${S} && patch -p1 <${FILESDIR}/mutella-gcc3-gentoo.patch || die
}

src_compile() {
	econf
	emake || die "compile problem"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	dodoc AUTHORS ChangeLog COPYING INSTALL KNOWN-BUGS README TODO
}
