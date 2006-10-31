# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/elianna-pack/elianna-pack-1.0.ebuild,v 1.2 2006/10/31 19:12:18 gustavoz Exp $

DESCRIPTION="Argentinean spanish sounds for asterisk"
HOMEPAGE="http://www.ip-flow.com.ar/elianna_pack.html"
SRC_URI="http://www.ip-flow.com.ar/downloads/elianna-pack_v1.0.tar.gz"
S="${WORKDIR}/${PN}_v${PV}"

LICENSE="CCPL-Attribution-NonCommercial-NoDerivs-2.5"
SLOT="0"
KEYWORDS="~sparc ~x86"
IUSE=""

DEPEND=">=net-misc/asterisk-1.2.0"

src_install() {
	dodoc LICENCIA.txt README.txt
	insinto /var/lib/asterisk/sounds/ar
	doins *.gsm
	insinto /var/lib/asterisk/sounds/ar/digits
	doins digits/*.gsm
	insinto /var/lib/asterisk/sounds/ar/letters
	doins letters/*.gsm

	# fix permissions
	einfo "Fixing permissions"
	chown -R asterisk:asterisk ${D}/var/lib/asterisk
	chmod -R u=rwX,g=rX,o=     ${D}/var/lib/asterisk
}

pkg_postinst() {
	einfo "Remember to enable this language pack via language=ar"
	einfo "entries in the corresponding /etc/asterisk/*.conf files"
}
