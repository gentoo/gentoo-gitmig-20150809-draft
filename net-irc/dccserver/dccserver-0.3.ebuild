# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/dccserver/dccserver-0.3.ebuild,v 1.3 2004/01/03 17:41:58 zul Exp $

DESCRIPTION="linux implementation of the mirc dccserver command"
SRC_URI="http://ftp.giga.or.at/pub/nih/dccserver/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"
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
