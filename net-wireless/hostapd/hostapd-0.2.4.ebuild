# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/hostapd/hostapd-0.2.4.ebuild,v 1.4 2005/01/18 11:21:36 brix Exp $

inherit toolchain-funcs eutils

DESCRIPTION="HostAP wireless daemon"
HOMEPAGE="http://hostap.epitest.fi/"
SRC_URI="http://hostap.epitest.fi/releases/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die
}

src_install() {
	diropts -o root -g root -m 0750
	dodir /etc/hostapd
	insopts -o root -g root -m 0640
	insinto /etc/hostapd
	exeopts ""
	exeinto /etc/init.d
	newexe "${FILESDIR}/hostapd.init.d" hostapd
	doins \
		hostapd.conf \
		hostapd.accept \
		hostapd.deny
	dosed 's:\(accept_mac_file=\)/etc/hostapd.accept:\1/etc/hostapd/hostapd.accept:g' /etc/hostapd/hostapd.conf
	dosed 's:\(deny_mac_file=\)/etc/hostapd.deny:\1/etc/hostapd/hostapd.deny:g' /etc/hostapd/hostapd.conf
	dosbin hostapd
	dodoc \
		README \
		developer.txt
}
