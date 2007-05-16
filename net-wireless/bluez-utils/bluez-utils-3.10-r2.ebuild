# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bluez-utils/bluez-utils-3.10-r2.ebuild,v 1.1 2007/05/16 09:51:54 betelgeuse Exp $

inherit eutils

DESCRIPTION="Bluetooth Tools and System Daemons for Linux"
HOMEPAGE="http://bluez.sourceforge.net/"
SRC_URI="http://bluez.sourceforge.net/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"

IUSE="alsa debug hal usb cups"

DEPEND="app-pda/libopensync
	>=net-wireless/bluez-libs-3.10
	hal? ( sys-apps/hal )
	usb? ( dev-libs/libusb )
	cups? ( net-print/cups )
	sys-fs/udev
	dev-libs/glib
	sys-apps/dbus"

src_unpack() {
	unpack ${A}
	# bundled glib
	cd "${S}"
	rm -r eglib/{*.c,*.h}  || die
}

src_compile() {
	econf \
		$(use_enable alsa audio) \
		$(use_enable alsa) \
		$(use_enable debug) \
		$(use_enable usb) \
		$(use_enable cups) \
		$(use_enable hal) \
		--enable-glib  \
		--enable-inotify \
		--enable-obex \
		--enable-input \
		--enable-sync \
		--enable-hcid \
		--enable-sdpd \
		--enable-hidd \
		--enable-configfiles \
		--disable-initscripts \
		--disable-pcmciarules \
		--enable-bccmd \
		--enable-avctrl \
		--enable-hid2hci \
		--enable-dfutool \
		--localstatedir=/var \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog README || die

	# optional bluetooth utils
	dosbin tools/hcisecfilter tools/ppporc
	dobin daemon/passkey-agent

	newinitd "${FILESDIR}/${PN}-3.10-init.d" bluetooth || die
	newconfd "${S}/scripts/bluetooth.default" bluetooth || die

	# bug #84431
	insinto /etc/udev/rules.d/
	newins "${FILESDIR}/${PN}-2.24-udev.rules" 70-bluetooth.rules || die
	newins "${S}/scripts/bluetooth.rules" 70-bluetooth-pcmcia.rules || die

	exeinto /lib/udev/
	newexe "${FILESDIR}/${PN}-2.24-udev.script" bluetooth.sh || die
	doexe  "${S}/scripts/bluetooth_serial" || die
}

pkg_postinst() {
	udevcontrol reload_rules && udevtrigger

	elog "If you use hidd, add --encrypt to the HIDD_OPTIONS in"
	elog "/etc/conf.d/bluetooth to secure your connection"
	elog
	elog "To use dund you must install net-dialup/ppp"
	elog ""
	elog "Since 3.0 bluez has changed the passkey handling to use a dbus based"
	elog "API so please remember to update your /etc/bluetooth/hcid.conf."
	elog "For a password asking program, there is for example"
	elog "net-wireless/bluez-gnome for gnome and net-wireless/kdebluetooth"
	elog "for kde."
}
