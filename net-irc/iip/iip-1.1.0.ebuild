# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/iip/iip-1.1.0.ebuild,v 1.3 2004/04/27 22:10:50 agriffis Exp $

inherit eutils

S="${WORKDIR}/${P}/src"
DESCRIPTION="Proxy server for encrypted anonymous irc-like network"
HOMEPAGE="http://www.invisiblenet.net/iip/"
SRC_URI="mirror://sourceforge/invisibleip/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/glibc"
RDEPEND=""

src_compile() {
	emake || die
}

src_install() {
	ehome=/home/iip
	enewuser iip
	dodir /usr/man/man1
	dodir /usr/bin
	dodir /usr/share/iip
	make PREFIX=${D}usr INSTALLFILEPATH=${D}usr/share/iip/ install || die
	cd ${WORKDIR}/${P}
	dodoc AUTHORS  CHANGELOG  COPYING  INSTALL  README
}

