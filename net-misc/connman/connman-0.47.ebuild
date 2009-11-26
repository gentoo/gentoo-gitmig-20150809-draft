# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/connman/connman-0.47.ebuild,v 1.1 2009/11/26 15:59:06 dagger Exp $

EAPI="2"

DESCRIPTION="Provides a daemon for managing internet connections"
HOMEPAGE="http://connman.net"
SRC_URI="mirror://kernel/linux/network/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm ~amd64 ~x86"
IUSE="3G bluetooth debug +dhclient dnsproxy doc +ethernet modemmanager ofono policykit ppp resolvconf threads tools +udev +wifi"
# ospm wimax

RDEPEND=">=dev-libs/glib-2.16
	>=sys-apps/dbus-1.2
	bluetooth? ( net-wireless/bluez )
	dhclient? ( net-misc/dhcp )
	modemmanager? ( net-misc/modemmanager )
	ofono? ( net-misc/ofono )
	policykit? ( >=sys-auth/policykit-0.7 )
	ppp? ( net-dialup/ppp )
	resolvconf? ( net-dns/openresolv )
	udev? ( >=sys-fs/udev-141 )
	wifi? ( net-wireless/wpa_supplicant[dbus] )"

DEPEND="${RDEPEND}
	doc? ( dev-util/gtk-doc )"

src_configure() {
	econf \
		--localstatedir=/var \
		--enable-loopback \
		--enable-client \
		--enable-fake \
		--enable-datafiles \
		$(use_enable 3G novatel) \
		$(use_enable 3G huawei) \
		$(use_enable 3G hso) \
		$(use_enable 3G mbm) \
		$(use_enable bluetooth) \
		$(use_enable debug) \
		$(use_enable dhclient) \
		$(use_enable dnsproxy) \
		$(use_enable doc gtk-doc) \
		$(use_enable ethernet) \
		$(use_enable modemmanager modemmgr) \
		$(use_enable ofono) \
		$(use_enable policykit polkit) \
		$(use_enable ppp) \
		$(use_enable resolvconf) \
		$(use_enable threads) \
		$(use_enable tools) \
		$(use_enable udev) \
		$(use_enable wifi) \
		--disable-udhcp \
		--disable-iwmx \
		--disable-iospm
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dobin client/cm || die "client installation failed"

	keepdir /var/lib/${PN} || die
	newinitd "${FILESDIR}"/${PN}.initd ${PN} || die

}
