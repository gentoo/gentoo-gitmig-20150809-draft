# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bluez-utils/bluez-utils-3.10.1.ebuild,v 1.1 2007/05/16 12:34:45 betelgeuse Exp $

inherit eutils

DESCRIPTION="Bluetooth Tools and System Daemons for Linux"
HOMEPAGE="http://bluez.sourceforge.net/"
SRC_URI="http://bluez.sourceforge.net/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"

IUSE="cups debug examples hal old-daemons test-programs usb"

DEPEND="
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
	# the order is the same as ./configure --help

	# we don't need the other daemons either with the new
	# service architechture
	# hcid has in integrated sdpd now that we use

	# These are currently under work and don't work properly:
	# --enable-alsa
	# --enable-sync
	# --enable-obex
	# Only for embedded devices
	# --enable-audio

	econf \
		$(use_enable debug) \
		--enable-inotify \
		$(use_enable hal) \
		$(use_enable usb) \
		--enable-glib  \
		--disable-obex \
		--disable-alsa \
		--enable-network \
		--enable-serial \
		--enable-input \
		--disable-audio \
		--disable-sync \
		$(use_enable examples echo) \
		--enable-hcid \
		$(use_enable test-programs test) \
		$(use_enable old-daemons sdpd) \
		$(use_enable old-daemons hidd) \
		$(use_enable old-daemons pand) \
		$(use_enable cups) \
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

	# a very simple example daemon
	dobin daemon/passkey-agent || die

	newinitd "${FILESDIR}/${PN}-3.10.1-init.d" bluetooth || die
	newconfd "${S}/scripts/bluetooth.default" bluetooth || die

	# bug #84431
	insinto /etc/udev/rules.d/
	newins "${FILESDIR}/${PN}-3.10.1-udev.rules" 70-bluetooth.rules || die
	newins "${S}/scripts/bluetooth.rules" 70-bluetooth-pcmcia.rules || die

	exeinto /lib/udev/
	newexe "${FILESDIR}/${PN}-3.10.1-udev.script" bluetooth.sh || die
	doexe  "${S}/scripts/bluetooth_serial" || die
}

pkg_postinst() {
	udevcontrol reload_rules && udevtrigger

	elog
	elog "To use dial up networking you must install net-dialup/ppp"
	elog ""
	elog "Since 3.0 bluez has changed the passkey handling to use a dbus based"
	elog "API so please remember to update your /etc/bluetooth/hcid.conf."
	elog "For a password asking program, there is for example"
	elog "net-wireless/bluez-gnome for gnome and net-wireless/kdebluetooth"
	elog "for kde."
	elog ""
	elog "Since 3.10.1 we don't install the old style daemons any more but rely"
	elog "on the new service architechture:"
	elog "http://wiki.bluez.org/wiki/Services"
	elog "See /etc/bluetooth/*.service for enabling the services."
	elog "Use the old-daemons use flag to get the old daemons like hidd"
	elog "installed. Please note that the init script doesn't stop the old"
	elog "daemons after you update it so it's recommended to run:"
	elog "  /etc/init.d/bluetooth stop"
	elog "before updating your configuration files or you can manually kill"
	elog "the extra daemons you enable in /etc/conf.d/bluetooth."
	elog ""
}
