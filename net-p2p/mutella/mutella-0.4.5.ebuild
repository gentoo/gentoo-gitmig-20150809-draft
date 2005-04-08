# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/mutella/mutella-0.4.5.ebuild,v 1.4 2005/04/08 18:03:12 hansmi Exp $

DESCRIPTION="Text-mode gnutella client"
SRC_URI="mirror://sourceforge/mutella/${P}.tar.gz"
HOMEPAGE="http://mutella.sourceforge.net/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~amd64 ~ppc-macos"
IUSE="debug"
DEPEND="virtual/libc
	sys-libs/readline"

src_compile() {
	econf --enable-optimization \
		`use_enable debug` || die "econf failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING INSTALL LICENSE KNOWN-BUGS README TODO
}
