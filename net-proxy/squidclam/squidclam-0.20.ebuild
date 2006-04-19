# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/squidclam/squidclam-0.20.ebuild,v 1.2 2006/04/19 18:07:59 mrness Exp $

DESCRIPTION="A redirector for Squid which scans accessed URLs for viruses, using Clam Anti-Virus"
HOMEPAGE="http://squidclam.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="as-is"

SLOT="0"
KEYWORDS="~sparc ~x86"
IUSE=""
DEPEND="net-misc/curl
	app-antivirus/clamav"
RDEPEND="${DEPEND}
	net-proxy/squid"

src_compile() {
	./configure || die "configure failed"
	cd src && emake || die "make failed"
}

src_install() {
	dobin src/squidclam
	insinto /etc
	newins sample.conf squidclam.conf
	dodoc antivir.php README Changelog TODO sample.conf
}

pkg_postinst() {
	ewarn "THIS PACKAGE IS IN ITS EARLY DEVELOPMENT STAGE!"
	ewarn "See ${HOMEPAGE} for more info."
	echo
	einfo "Add following lines to your squid.conf:"
	einfo "${HILITE}    redirect_program /usr/bin/squidclam ${NORMAL}"
	einfo "${HILITE}    redirect_children 15 ${NORMAL} # make a wise choice"
	einfo "and this line to your acl list to prevent loops:"
	einfo "${HILITE}    redirector_access deny localhost ${NORMAL}"
	echo
	ewarn "Squid doesn't pass complete ssl urls to the redirector!"
	ewarn "Therefore scanning them is pretty useless."
	ewarn "Add something like the following to avoid this and save bandwidth:"
	einfo "${HILITE}    acl SSL_ports port 443 563 ${NORMAL}"
	einfo "${HILITE}    redirector_access deny SSL_ports ${NORMAL}"
	echo
}
