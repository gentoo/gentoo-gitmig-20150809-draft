# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-app_notify/asterisk-app_notify-1.0_rc2.ebuild,v 1.1 2006/04/15 23:49:22 stkn Exp $

inherit eutils

MY_PN="app_notify"

DESCRIPTION="Asterisk application plugin to notify users"
HOMEPAGE="http://www.mezzo.net/asterisk/"
SRC_URI="http://www.mezzo.net/asterisk/${MY_PN}-${PV/_/}.tgz"

IUSE=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=net-misc/asterisk-1.0.7-r1"

S="${WORKDIR}/${MY_PN}-${PV/_/}"

src_unpack() {
	unpack ${A}

	cd ${S}
	# use asterisk-config...
	epatch ${FILESDIR}/${MY_PN}-0.9-astcfg.diff
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc README sampleClient.c
}
