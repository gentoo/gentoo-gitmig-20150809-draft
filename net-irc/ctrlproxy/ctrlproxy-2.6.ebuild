# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/ctrlproxy/ctrlproxy-2.6.ebuild,v 1.1 2004/01/08 19:15:47 agriffis Exp $

IUSE="ssl"

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
	dev-libs/libpcre
	ssl? ( dev-libs/openssl )"

src_compile() {
	use alpha && append-flags -fPIC
	econf || die
	emake || die
}

src_install() {
	make install \
		DESTDIR=${D} \
		man1dir=/usr/share/man/man1 \
		man5dir=/usr/share/man/man5 || die
	gzip ${D}/usr/share/doc/*/*
	dodoc ctrlproxyrc.example
}
