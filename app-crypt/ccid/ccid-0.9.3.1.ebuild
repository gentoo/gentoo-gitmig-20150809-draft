# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/ccid/ccid-0.9.3.1.ebuild,v 1.1 2005/07/20 21:44:06 dragonheart Exp $

inherit eutils

DESCRIPTION="CCID free software driver"
HOMEPAGE="http://pcsclite.alioth.debian.org/ccid.html"
MY_PV=${PV%.*}
MY_PV_P=${PV/*[^.].}
SRC_URI="mirror://debian/pool/main/c/ccid/ccid_${MY_PV}.orig.tar.gz
	mirror://debian/pool/main/c/ccid/ccid_${MY_PV}-${MY_PV_P}.diff.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
S="${WORKDIR}/ccid-${MY_PV}.orig"
RDEPEND=">=sys-apps/pcsc-lite-1.2.9_beta6
	>=dev-libs/libusb-0.1.4"


src_unpack () {
	unpack ${A}
	cd ${S}
	epatch "${WORKDIR}/ccid_${MY_PV}-${MY_PV_P}.diff"
}

src_install() {
	cd ccid-${MY_PV}.orig
	make install DESTDIR=${D} || die "Cannot install"

	dodoc README
	dodoc AUTHORS
	dodoc COPYING
}
