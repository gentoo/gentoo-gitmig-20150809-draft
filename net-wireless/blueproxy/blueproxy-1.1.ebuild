# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/blueproxy/blueproxy-1.1.ebuild,v 1.1 2004/10/09 19:22:15 liquidx Exp $

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
	emake OS=linux SDPFLAGS=-lbluetooth || die "make failed"
}

src_install() {
	dobin blueproxy bluepinger bluelistener
	doman blueproxy.1
	dodoc README
}