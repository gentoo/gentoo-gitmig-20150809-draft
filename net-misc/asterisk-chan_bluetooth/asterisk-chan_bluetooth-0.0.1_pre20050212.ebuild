# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-chan_bluetooth/asterisk-chan_bluetooth-0.0.1_pre20050212.ebuild,v 1.1 2005/02/15 20:41:28 stkn Exp $

inherit eutils

MY_PN="chan_bluetooth"

DESCRIPTION="Asterisk channel plugin for bluetooth HandsFree Profile"
HOMEPAGE="http://www.crazygreek.co.uk/content/chan_bluetooth"
SRC_URI="mirror://gentoo/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND=">=net-wireless/bluez-libs-2.10
	>=net-misc/asterisk-1.0.5-r1"

S=${WORKDIR}/${MY_PN}

src_unpack() {
	unpack ${A}

	cd ${S}
	# apply asterisk-config patch
	epatch ${FILESDIR}/${MY_PN}-0.0.0-astcfg.diff
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc README TODO ChangeLog
}
