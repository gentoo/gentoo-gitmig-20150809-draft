# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/hashcash/hashcash-1.16.ebuild,v 1.2 2005/02/04 23:47:02 blubb Exp $

IUSE=""
DESCRIPTION="Utility to generate hashcash tokens"
HOMEPAGE="http://www.hashcash.org"
SRC_URI="http://www.hashcash.org/source/${P}.tgz"

LICENSE="CPL-1.0"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

DEPEND="virtual/libc"
RDEPEND=""

src_compile() {
	sed -i \
		-e "s|^CFLAGS.*\$|CFLAGS = ${CFLAGS}|" \
		-e "s|^INSTALL_PATH.*\$|INSTALL_PATH = \$(PREFIX)/bin|" \
		-e "s|^MAN_INSTALL_PATH.*\$|MAN_INSTALL_PATH = \$(PREFIX)/share/man/man1|" \
		Makefile || die

	emake || die
}

src_install() {
	dobin hashcash
	doman hashcash.1 sha1.1
}
