# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/tlsproxyd/tlsproxyd-0.0.2.ebuild,v 1.7 2004/07/15 03:38:39 agriffis Exp $

IUSE=""
DESCRIPTION="An TLS Tunneling Tool."
SRC_URI="http://www.ex-parrot.com/~chris/tlsproxyd/${P}.tar.gz"
HOMEPAGE="http://www.ex-parrot.com/~chris/tlsproxyd/"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/libc
	>=dev-libs/openssl-0.9.6"

src_compile() {
	emake || die
}

src_install () {
	dosbin tlsproxyd
	doman tlsproxyd.8
	dodir /etc/tlsproxyd
}
pkg_postinst() {
	einfo "Read the tlsproxyd MAN-Page"
	einfo "Please create /etc/tlsproxyd/tlsproxyd.conf to fit your Configuration"
	einfo "init Script not included in this distribution. Shouldnt be to hard to create one on your own!"
}
