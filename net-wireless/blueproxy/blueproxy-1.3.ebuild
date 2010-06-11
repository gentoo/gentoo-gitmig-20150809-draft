# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/blueproxy/blueproxy-1.3.ebuild,v 1.7 2010/06/11 11:24:48 ssuominen Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Bluetooth RFCOMM to TCP proxy"
HOMEPAGE="http://anil.recoil.org/projects/blueproxy.html"
SRC_URI="http://anil.recoil.org/projects/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm x86"
IUSE=""

RDEPEND="net-wireless/bluez"

src_compile() {
	tc-export CC LD
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
