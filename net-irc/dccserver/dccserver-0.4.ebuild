# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/dccserver/dccserver-0.4.ebuild,v 1.3 2004/05/29 16:16:27 pvdabeel Exp $

DESCRIPTION="linux implementation of the mirc dccserver command"
SRC_URI="http://www.nih.at/dccserver/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
HOMEPAGE="http://www.nih.at/dccserver/"

DEPEND="virtual/glibc"

src_compile() {
	econf || die "Configure failed"
	emake || die "make failed"
}

src_install() {
	einstall
	dodoc AUTHORS NEWS THANKS TODO
}
