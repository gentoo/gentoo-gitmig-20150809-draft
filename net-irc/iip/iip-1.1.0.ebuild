# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/iip/iip-1.1.0.ebuild,v 1.7 2004/07/27 17:27:18 swegener Exp $

DESCRIPTION="Proxy server for encrypted anonymous IRC-like network"
HOMEPAGE="http://www.invisiblenet.net/iip/"
SRC_URI="mirror://sourceforge/invisibleip/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

S="${WORKDIR}/${P}/src"

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}

	sed -i -e "s/-g -Wall -O2/${CFLAGS}/" ${S}/Makefile || die "sed failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dodir /usr/bin /usr/share/man/man1

	make \
		PREFIX=${D}/usr \
		INSTALLMANDST=${D}/usr/share/man/man1/ \
		INSTALLFILEPATH=${D}/usr/share/iip/ \
		INSTALLUSER=root \
		install || die "make install failed"

	cd ${WORKDIR}/${P}
	dodoc AUTHORS CHANGELOG README
}
