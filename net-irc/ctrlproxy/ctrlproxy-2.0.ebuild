# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/ctrlproxy/ctrlproxy-2.0.ebuild,v 1.3 2003/03/20 18:28:13 agriffis Exp $

DESCRIPTION="IRC proxy with multiserver and multiclient support"
HOMEPAGE="http://people.nl.linux.org/~jelmer/ctrlproxy.php"
SRC_URI="http://people.nl.linux.org/~jelmer/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~alpha"
IUSE=""
DEPEND=""

src_compile() {
	emake PREFIX=/usr CC="${CC} ${CFLAGS}" || die
}

src_install() {
	make install DESTDIR=${D} PREFIX=/usr DOCDIR=/usr/share/doc/${P} || die
	gzip ${D}/usr/share/doc/*/*
	dodoc ctrlproxyrc.example
}
