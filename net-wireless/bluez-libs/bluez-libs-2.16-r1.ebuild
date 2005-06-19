# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bluez-libs/bluez-libs-2.16-r1.ebuild,v 1.6 2005/06/19 05:29:23 hansmi Exp $

inherit eutils

DESCRIPTION="Bluetooth Userspace Libraries"
HOMEPAGE="http://bluez.sourceforge.net/"
SRC_URI="http://bluez.sourceforge.net/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ~ia64 ppc ppc64 ~sparc x86"
IUSE=""

DEPEND="!net-wireless/bluez-sdp"

src_unpack() {
	unpack ${A}
	cd ${S}/include
	epatch ${FILESDIR}/${PV}-bluetooth.h.patch
}

src_install() {
	make DESTDIR="${D}" install || die
}
