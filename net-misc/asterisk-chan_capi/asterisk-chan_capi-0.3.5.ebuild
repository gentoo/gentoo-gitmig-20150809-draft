# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-chan_capi/asterisk-chan_capi-0.3.5.ebuild,v 1.4 2007/01/06 16:50:51 drizzt Exp $

IUSE="fax"

inherit eutils

MY_PN="chan_capi"

DESCRIPTION="CAPI2.0 channel module for Asterisk"
HOMEPAGE="http://www.junghanns.net/asterisk/"
SRC_URI="http://www.junghanns.net/asterisk/downloads/${MY_PN}.${PV}.tar.gz
	 fax? ( http://mlkj.net/asterisk/${MY_PN}-${PV}-patch.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=net-misc/asterisk-1.0.5-r1
	!>=net-misc/asterisk-1.1.0
	net-dialup/capi4k-utils"

S="${WORKDIR}"/${MY_PN}-${PV}

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}"/${MY_PN}-${PV}-gentoo.diff

	if use fax; then
		einfo "Enabling fax support"
		epatch "${WORKDIR}"/chan_capi.diff
		cp "${WORKDIR}"/app_capiFax.c "${S}"
	fi
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	make INSTALL_PREFIX="${D}" install config || die "make install failed"

	dodoc INSTALL LICENSE README capi.conf
}

pkg_postinst() {
	elog "Please don't forget to enable chan_capi in your /etc/asterisk/modules.conf:"
	echo
	elog "load => chan_capi.so"
	echo
	elog "and in the global section:"
	elog "chan_capi.so=yes"
	echo
	elog "(see /usr/share/doc/${PF} for more information)"
}
