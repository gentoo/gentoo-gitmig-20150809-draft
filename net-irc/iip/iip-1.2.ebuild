# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/iip/iip-1.2.ebuild,v 1.3 2004/01/24 16:19:17 zul Exp $

MY_P="iip-1.2-dev1"

DESCRIPTION="Proxy server for encrypted anonymous irc-like network"
HOMEPAGE="http://www.invisiblenet.net/iip/"
SRC_URI="mirror://sourceforge/invisibleip/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/glibc
		dev-libs/openssl
		>=sys-apps/sed-4"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

src_compile() {
	econf || die

	sed -i \
			-e "s:-Werror::" ${S}/src/Makefile || \
						die "sed Makefile failed"

	emake || die
}

src_install() {
	ehome=/home/iip
	enewuser iip
	dodir /usr/man/man1
	dodir /usr/bin
	dodir /usr/share/iip
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man install || die
	dodoc AUTHORS  CHANGELOG  COPYING  INSTALL  README

}

