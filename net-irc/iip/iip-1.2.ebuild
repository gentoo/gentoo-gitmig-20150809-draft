# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/iip/iip-1.2.ebuild,v 1.1 2004/01/19 01:32:48 zul Exp $

MY_P="iip-1.2-dev1"

DESCRIPTION="Proxy server for encrypted anonymous irc-like network"
HOMEPAGE="http://www.invisiblenet.net/iip/"
SRC_URI="mirror://sourceforge/invisibleip/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/glibc
		dev-libs/openssl"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
	ehome=/home/iip
	enewuser iip
	dodir /usr/man/man1
	dodir /usr/bin
	dodir /usr/share/iip
	make PREFIX=${D}/usr INSTALLFILEPATH=${D}/usr/share/iip/ install || die
	dodoc AUTHORS  CHANGELOG  COPYING  INSTALL  README
}

