# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bluez-libs/bluez-libs-2.10.ebuild,v 1.8 2004/11/04 13:29:38 weeve Exp $

inherit eutils

DESCRIPTION="Bluetooth Userspace Libraries"
HOMEPAGE="http://bluez.sourceforge.net/"
SRC_URI="http://bluez.sourceforge.net/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc sparc x86 ~alpha"
IUSE=""

DEPEND="!net-wireless/bluez-sdp"

src_unpack() {
	unpack ${A}
	cd ${S}; epatch ${FILESDIR}/${P}-handsfree.patch
}

src_install() {
	make DESTDIR=${D} install || die
}
