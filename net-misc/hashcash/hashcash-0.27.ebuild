# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/hashcash/hashcash-0.27.ebuild,v 1.1 2003/09/12 00:42:24 zul Exp $

DESCRIPTION="Utility to generate hashcash tokens"
HOMEPAGE="http://www.cypherspace.org/hashcash/"
SRC_URI="http://www.cypherspace.org/hashcash/source/${P}.tgz"

LICENSE="CPL"
SLOT="0"

KEYWORDS="~x86"

IUSE=""

DEPEND="virtual/glibc"
RDEPEND=""
S=${WORKDIR}/${P}

src_compile() {

	sed -e "s|^CFLAGS.*\$|CFLAGS = ${CFLAGS}|" \
	  -e "s|^INSTALL_PATH.*\$|INSTALL_PATH = \$(PREFIX)/bin|" \
	  -e "s|^MAN_INSTALL_PATH.*\$|MAN_INSTALL_PATH = \$(PREFIX)/share/man/man1|" \
	  -i Makefile || die

	emake || die
	
}

src_install() {
	dosbin hashcash
	doman hashcash.1 sha1.1
}
