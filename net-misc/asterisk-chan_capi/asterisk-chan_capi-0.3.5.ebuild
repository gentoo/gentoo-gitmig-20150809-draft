# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-chan_capi/asterisk-chan_capi-0.3.5.ebuild,v 1.1 2005/02/21 01:32:39 stkn Exp $

inherit eutils

MY_PN="chan_capi"

DESCRIPTION="CAPI2.0 channel module for Asterisk"
HOMEPAGE="http://www.junghanns.net/asterisk/"
SRC_URI="http://www.junghanns.net/asterisk/downloads/${MY_PN}.${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND=">=net-misc/asterisk-1.0.5-r1
	net-dialup/capi4k-utils"

S=${WORKDIR}/${MY_PN}-${PV}

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${MY_PN}-${PV}-gentoo.diff
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	make INSTALL_PREFIX=${D} install config || die "make install failed"

	dodoc INSTALL LICENSE README capi.conf
}

pkg_postinst() {
	einfo "Please don't forget to enable chan_capi in your /etc/asterisk/modules.conf:"
	einfo ""
	einfo "load => chan_capi.so"
	einfo ""
	einfo "and in the global section:"
	einfo "chan_capi.so=yes"
	einfo ""
	einfo "(see /usr/share/doc/${PF} for more information)"
}
