# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/blueproxy/blueproxy-1.3.ebuild,v 1.3 2007/02/02 19:33:02 mr_bones_ Exp $

inherit eutils

DESCRIPTION="Bluetooth RFCOMM to TCP proxy"
HOMEPAGE="http://anil.recoil.org/projects/blueproxy.html"
SRC_URI="http://anil.recoil.org/projects/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=net-wireless/bluez-libs-2.10"

src_compile() {
	econf
	emake || die "make failed"
	#emake OS=linux SDPFLAGS=-lbluetooth || die "make failed"
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/man/man1

	einstall || die "installe failed"
	dodoc README AUTHORS ChangeLog
}
