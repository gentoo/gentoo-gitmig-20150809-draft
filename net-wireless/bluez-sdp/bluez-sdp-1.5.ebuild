# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bluez-sdp/bluez-sdp-1.5.ebuild,v 1.4 2004/02/12 18:32:33 ciaranm Exp $

DESCRIPTION="bluetooth service discovery protocol (sdp) utilities"
HOMEPAGE="http://bluez.sourceforge.net/"
SRC_URI="http://bluez.sourceforge.net/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc"
IUSE=""
DEPEND=">=net-wireless/bluez-libs-2.4"

src_compile() {
	econf
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
