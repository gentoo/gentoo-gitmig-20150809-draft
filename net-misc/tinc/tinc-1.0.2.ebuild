# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/tinc/tinc-1.0.2.ebuild,v 1.3 2004/06/25 00:15:24 agriffis Exp $


DESCRIPTION="tinc is an easy to configure VPN implementation"
HOMEPAGE="http://tinc.nl.linux.org/"
SRC_URI="http://tinc.nl.linux.org/packages/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE=""
DEPEND=">=dev-libs/openssl-0.9.7c
		virtual/linux-sources
		>=dev-libs/lzo-1.08
		>=sys-libs/zlib-1.1.4-r2"

src_compile() {
	econf --enable-jumbograms || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc ABOUT-NLS AUTHORS COPYING COPYING.README INSTALL NEWS README THANKS TODO
	exeinto /etc/init.d ; newexe ${FILESDIR}/tincd tincd
}

pkg_postinst() {
	einfo "This package requires the tun/tap kernel device."
	einfo "Look at http://tinc.nl.linux.org/ for how to configure tinc"
}
