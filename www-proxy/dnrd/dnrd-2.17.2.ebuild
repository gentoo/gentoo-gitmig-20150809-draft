# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-proxy/dnrd/dnrd-2.17.2.ebuild,v 1.1 2004/12/09 02:50:52 chriswhite Exp $

inherit gnuconfig

DESCRIPTION="A caching DNS proxy server"
HOMEPAGE="http://dnrd.sourceforge.net/"
SRC_URI="mirror://sourceforge/dnrd/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="debug"
DEPEND=""

src_unpack() {
	unpack ${A}
	gnuconfig_update
}

src_compile() {
	econf \
	$(use_enable debug) \
	|| die "configuration failed"

	emake || die "Make failed"
}

src_install() {
	make DESTDIR=${D} install || die

	doinitd ${FILESDIR}/dnrd
	newconfd ${FILESDIR}/dnrd.conf dnrd
}
