# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/rtg/rtg-0.7.4.ebuild,v 1.1 2004/02/08 19:26:36 anti Exp $

inherit eutils

DESCRIPTION="RTG: Real Traffic Grabber"
HOMEPAGE="http://rtg.sourceforge.net/"
SRC_URI="mirror://sourceforge/rtg/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=dev-db/mysql-3.23.52-r1
	>=net-analyzer/net-snmp-5.0.9-r1"

src_compile() {
	epatch ${FILESDIR}/${P}-pathfix.patch

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc/rtg \
		--datadir=/usr/share/rtg \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"

	emake || die
}

src_install() {
	einstall || die

	dodoc FAQ README
}

pkg_postinst() {
	einfo "RTG has been installed."
	einfo ""
	einfo "The default configuration file location is now /etc/rtg"
	einfo ""
	einfo "Sample reports have been installed into /usr/share/rtg"
}