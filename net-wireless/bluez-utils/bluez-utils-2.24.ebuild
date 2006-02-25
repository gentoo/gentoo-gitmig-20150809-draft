# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bluez-utils/bluez-utils-2.24.ebuild,v 1.3 2006/02/25 18:55:57 liquidx Exp $

inherit eutils

DESCRIPTION="Bluetooth Tools and System Daemons for Linux"
HOMEPAGE="http://bluez.sourceforge.net/"
SRC_URI="http://bluez.sourceforge.net/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc x86"

IUSE="alsa cups dbus gtk pcmcia udev"

RDEPEND="!net-wireless/bluez-pan
		>=net-wireless/bluez-libs-2.22
		dev-libs/libusb
		alsa? ( >=media-libs/alsa-lib-1.0.9 )
		cups? ( net-print/cups )
		dbus? ( >=sys-apps/dbus-0.31 )
		gtk? ( >=dev-python/pygtk-2.2 )
		pcmcia? ( virtual/pcmcia
				  sys-apps/setserial )
		udev? ( sys-fs/udev )"
DEPEND="sys-devel/bison
		sys-devel/flex
		>=sys-apps/sed-4
		${RDEPEND}"

src_unpack() {
	unpack ${A}

	sed -i \
		-e "s:^HIDD_ENABLE=.*:HIDD_ENABLE=false:" \
		-e "s:^HID2HCI_ENABLE=.*:HID2HCI_ENABLE=false:" \
		${S}/scripts/bluetooth.default

	sed -i \
		-e "s:security .*;:security user;:" \
		${S}/hcid/hcid.conf

	if use gtk; then
		sed -i -e "s:\(pin_helper \).*:\1/usr/bin/bluepin;:" \
			${S}/hcid/hcid.conf
	else
		sed -i -e "s:\(pin_helper \).*:\1/etc/bluetooth/pin-helper;:" \
			${S}/hcid/hcid.conf
	fi
}

src_compile() {
	econf \
		$(use_enable alsa) \
		$(use_enable cups) \
		$(use_enable dbus) \
		$(use_enable pcmcia) \
		$(use_enable gtk bluepin) \
		--enable-avctrl \
		--enable-bcm203x \
		--enable-dfutool \
		--enable-hid2hci \
		--enable-obex \
		--disable-initscripts \
		--localstatedir=/var \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog README

	# optional bluetooth utils
	cd ${S}/tools
	dosbin bccmd hcisecfilter ppporc pskey

	exeinto /etc/bluetooth
	newexe ${FILESDIR}/${P}-pin-helper.sh pin-helper

	insinto /etc/bluetooth
	newins ${FILESDIR}/${P}-pin pin
	fperms 0600 /etc/bluetooth/pin

	newinitd ${FILESDIR}/${P}-init.d bluetooth
	newconfd ${S}/scripts/bluetooth.default bluetooth

	# bug #103498
	if use pcmcia; then
		fperms 755 /etc/pcmcia/bluetooth
	fi

	# bug #84431
	if use udev; then
		insinto /etc/udev/rules.d/
		newins ${FILESDIR}/${P}-udev.rules 70-bluetooth.rules

		exeinto /lib/udev/
		newexe ${FILESDIR}/${P}-udev.script bluetooth.sh
	fi
}

pkg_postinst() {
	einfo
	einfo "A startup script has been installed in /etc/init.d/bluetooth."
	einfo
	einfo "If you need to set a default PIN, edit /etc/bluetooth/pin, and change"
	einfo "/etc/bluetooth/hcid.conf option 'pin_helper' to /etc/bluetooth/pin-helper."
	einfo

	if use gtk; then
		einfo "By default, /usr/bin/bluepin will be launched on the desktop display"
		einfo "for pin number input."
		einfo
	fi

	if use udev; then
		einfo "You need to run 'udevstart' or reboot for the udev rules to take effect."
		einfo
	fi
}
