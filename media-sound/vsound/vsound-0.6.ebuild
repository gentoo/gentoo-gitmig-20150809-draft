# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/vsound/vsound-0.6.ebuild,v 1.1 2004/07/26 05:21:24 eradicator Exp $

IUSE=""

inherit gnuconfig

DESCRIPTION="A virtual audio loopback cable"
HOMEPAGE="http://www.zorg.org/${PN}/"
LICENSE="GPL-2"
DEPEND=">=media-sound/sox-12.17.1"

KEYWORDS="~x86 ~amd64 ~sparc"
SLOT="0"
SRC_URI="http://www.zorg.org/${PN}/${P}.tar.gz"

src_unpack() {
	unpack ${A}
	cd ${S}
	gnuconfig_update
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS COPYING Changelog INSTALL NEWS README
}

pkg_postinst() {
	einfo
	einfo "To use this program to, for instance, record audio from realplayer:"
	einfo "  vsound realplay realmediafile.rm"
	einfo
	einfo "Or, to listen to realmediafile.rm at the same time:"
	einfo "  vsound -d realplay realmediafile.rm"
	einfo
	einfo "See ${HOMEPAGE} or /usr/share/doc/${PF}/README.gz for more info"
	einfo
}
