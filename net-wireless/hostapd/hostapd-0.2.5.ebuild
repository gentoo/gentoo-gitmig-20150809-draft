# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/hostapd/hostapd-0.2.5.ebuild,v 1.3 2004/11/27 01:21:20 wschlich Exp $

inherit toolchain-funcs eutils

DESCRIPTION="HostAP wireless daemon"
HOMEPAGE="http://hostap.epitest.fi"
SRC_URI="http://hostap.epitest.fi/releases/${P}.tar.gz"
LICENSE="GPL-2"

KEYWORDS="x86"
IUSE=""
SLOT="0"

DEPEND=">=net-wireless/hostap-driver-0.1.0"

src_unpack() {
	unpack ${A}

	sed -i "s:^CC=gcc:CC=$(tc-getCC):" ${S}/Makefile
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	insinto /etc/hostapd
	doins hostapd.conf hostapd.accept hostapd.deny

	dosed 's:\(accept_mac_file=\)/etc/hostapd.accept:\1/etc/hostapd/hostapd.accept:g' \
		/etc/hostapd/hostapd.conf
	dosed 's:\(deny_mac_file=\)/etc/hostapd.deny:\1/etc/hostapd/hostapd.deny:g' \
		/etc/hostapd/hostapd.conf

	dosbin hostapd

	exeinto /etc/init.d
	newexe ${FILESDIR}/hostapd.init.d hostapd

	dodoc ChangeLog developer.txt README
}
