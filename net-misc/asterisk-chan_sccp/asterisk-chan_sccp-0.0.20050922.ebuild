# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-chan_sccp/asterisk-chan_sccp-0.0.20050922.ebuild,v 1.3 2010/10/28 10:22:10 ssuominen Exp $

inherit eutils

IUSE="debug"

MY_P="chan_sccp-${PV/0.0./}"

DESCRIPTION="SCCP channel plugin for the Asterisk soft PBX"
HOMEPAGE="http://chan-sccp.berlios.de/"
SRC_URI="ftp://ftp.berlios.de/pub/chan-sccp/${MY_P}.tar.bz2"

S="${WORKDIR}/${MY_P}"

SLOT="0"
KEYWORDS="~ppc ~x86"
LICENSE="GPL-2"

DEPEND=">=net-misc/asterisk-1.0.5-r2"

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}"/chan_sccp-20050902-gentoo.diff

	if ! use debug; then
		sed -i -e "s:^\(DEBUG=.*\):#\1:" Makefile
	fi
}

src_compile() {
	emake -j1 || die
}

src_install() {
	emake INSTALL_PREFIX="${D}" install || die

	dodoc conf/* contrib/*

	# fix permissions
	if [[ -n "$(egetent group asterisk)" ]]; then
		einfo "Fixing permissions..."
		chown -R root:asterisk "${D}"etc/asterisk
		chmod -R u=rwX,g=rX,o= "${D}"etc/asterisk
	fi
}

pkg_postinst() {
	ewarn "You have to disable asterisk's chan_skinny to use this module!"
	elog "Add \"noload => chan_skinny.so\" to ${ROOT}etc/asterisk/modules.conf"
}
