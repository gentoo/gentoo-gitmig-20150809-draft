# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/dnrd/dnrd-2.19.1.ebuild,v 1.2 2005/08/17 16:52:02 chriswhite Exp $

inherit gnuconfig eutils

DESCRIPTION="A caching DNS proxy server"
HOMEPAGE="http://dnrd.sourceforge.net/"
SRC_URI="mirror://sourceforge/dnrd/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="debug"
DEPEND=""

src_unpack() {
	unpack ${A}
	gnuconfig_update
}

src_compile() {
	econf \
	$(use_enable debug) \
	--disable-dependency-tracking \
	|| die "configuration failed"

	emake || die "Make failed"
}

src_install() {
	make DESTDIR=${D} install || die

	doinitd ${FILESDIR}/dnrd
	newconfd ${FILESDIR}/dnrd.conf dnrd
}

pkg_postinst() {
	enewgroup dnrd
	enewuser dnrd -1 /bin/false /dev/null dnrd
}
