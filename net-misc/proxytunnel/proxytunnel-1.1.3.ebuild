# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/proxytunnel/proxytunnel-1.1.3.ebuild,v 1.3 2004/07/01 21:45:18 squinky86 Exp $

IUSE=""
DESCRIPTION="program that connects stdin and stdout to a server somewhere on the network, through a standard HTTPS proxy"
HOMEPAGE="http://proxytunnel.sourceforge.net/"
SRC_URI="mirror://sourceforge/proxytunnel/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/libc"

S=${WORKDIR}

src_compile() {
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc CHANGES CREDITS README
}
