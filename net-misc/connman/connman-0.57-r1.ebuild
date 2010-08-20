# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

EAPI="2"

inherit multilib eutils

DESCRIPTION="Provides a daemon for managing internet connections"
HOMEPAGE="http://connman.net"
SRC_URI="mirror://kernel/linux/network/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bluetooth +caps debug +dhclient dnsproxy doc examples +ethernet google ofono policykit resolvconf threads tools +udev +wifi wimax"
# gps meego ospm openconnect

RDEPEND=">=dev-libs/glib-2.16
	>=sys-apps/dbus-1.2.24
	bluetooth? ( net-wireless/bluez )
	caps? ( sys-libs/libcap-ng )
	dhclient? ( net-misc/dhcp )
	ofono? ( net-misc/ofono )
	policykit? ( >=sys-auth/policykit-0.7 )
	resolvconf? ( net-dns/openresolv )
	udev? ( >=sys-fs/udev-141 )
	wifi? ( >=net-wireless/wpa_supplicant-0.7[dbus] )
	wimax? ( net-wireless/wimax )"

DEPEND="${RDEPEND}
	doc? ( dev-util/gtk-doc )"

src_prepare() {
	epatch "${FILESDIR}/${P}-fix-iptables-test.patch"
}

src_configure() {
	econf \
		--localstatedir=/var \
		--enable-client \
		--enable-fake \
		--enable-datafiles \
		--enable-loopback=builtin \
		$(use_enable caps capng) \
		$(use_enable example test) \
		$(use_enable ethernet ethernet builtin) \
		$(use_enable wifi wifi builtin) \
		$(use_enable bluetooth bluetooth builtin) \
		$(use_enable ofono ofono builtin) \
		$(use_enable dhclient dhclient builtin) \
		$(use_enable resolvconf resolvconf builtin) \
		$(use_enable dnsproxy dnsproxy builtin) \
		$(use_enable google google builtin) \
		$(use_enable policykit polkit builtin) \
		$(use_enable wimax iwmx builtin) \
		$(use_enable debug) \
		$(use_enable doc gtk-doc) \
		$(use_enable threads) \
		$(use_enable tools) \
		$(use_enable udev) \
		--disable-udhcp \
		--disable-iospm \
		--disable-hh2serial-gps \
		--disable-portal \
		--disable-meego \
		--disable-openconnect
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dobin client/cm || die "client installation failed"

	keepdir /var/"$(get_libdir)"/${PN} || die
	newinitd "${FILESDIR}"/${PN}.initd ${PN} || die
	newconfd "${FILESDIR}"/${PN}.confd ${PN} || die
}
