# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/ctrlproxy/ctrlproxy-3.0_alpha1.ebuild,v 1.1 2006/09/08 22:37:42 agriffis Exp $

inherit flag-o-matic

MY_P=${P/_/}
DESCRIPTION="IRC proxy with multiserver and multiclient support"
HOMEPAGE="http://ctrlproxy.vernstok.nl/"
SRC_URI="http://jelmer.vernstok.nl/releases/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha ~ppc ~ia64"
IUSE="ssl doc"

DEPEND=">=dev-libs/glib-2
	dev-libs/popt
	dev-libs/libxml2
	dev-libs/tdb
	dev-libs/libpcre
	ssl? ( dev-libs/openssl )"

S=${WORKDIR}/${MY_P}

src_compile() {
	# hack alert
	append-flags -fPIC
	econf || die
	emake || die
}

src_install() {
	make install \
		DESTDIR=${D} \
		man1dir=/usr/share/man/man1 \
		man5dir=/usr/share/man/man5 \
		docdir=/usr/share/doc/${P} || die
	gzip ${D}/usr/share/doc/${P}/*
	dodoc ctrlproxyrc.example
}
