# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/ctrlproxy/ctrlproxy-2.4.ebuild,v 1.1 2003/10/03 02:57:31 agriffis Exp $

DESCRIPTION="IRC proxy with multiserver and multiclient support"
HOMEPAGE="http://jelmer.vernstok.nl/${PN}/"
SRC_URI="http://jelmer.vernstok.nl/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~alpha ~x86"
IUSE=""
DEPEND="
	>=dev-libs/glib-2
	dev-libs/popt
	dev-libs/libxml2
	dev-libs/tdb
	dev-libs/libpcre"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make install \
		DESTDIR=${D} \
		DOCDIR=/usr/share/doc/${PF} \
		MANDIR=/usr/share/man || die
	gzip ${D}/usr/share/doc/*/*
	dodoc ctrlproxyrc.example
}
