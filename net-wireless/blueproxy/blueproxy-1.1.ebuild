# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/blueproxy/blueproxy-1.1.ebuild,v 1.4 2008/05/24 20:17:30 solar Exp $

inherit eutils

DESCRIPTION="Bluetooth RFCOMM to TCP proxy"
HOMEPAGE="http://anil.recoil.org/projects/blueproxy.html"
SRC_URI="http://anil.recoil.org/projects/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"
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
