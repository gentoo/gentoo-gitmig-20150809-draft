# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bluez-utils/bluez-utils-2.19.ebuild,v 1.1 2005/08/09 18:57:31 brix Exp $

IUSE="gtk alsa cups pcmcia dbus"

inherit eutils

DESCRIPTION="Bluetooth Tools and System Daemons for using Bluetooth under Linux"
HOMEPAGE="http://bluez.sourceforge.net/"
SRC_URI="http://bluez.sourceforge.net/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

RDEPEND=">=net-wireless/bluez-libs-2.19
	!net-wireless/bluez-pan
	dev-libs/libusb
	gtk? ( >=dev-python/pygtk-2.2 )
	alsa? ( media-libs/alsa-lib )
	cups? ( net-print/cups )
	dbus? ( >=sys-apps/dbus-0.23 )
	pcmcia? ( virtual/pcmcia sys-apps/setserial )"

DEPEND="sys-devel/bison
	sys-devel/flex
	>=sys-apps/sed-4
	${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	if ! use gtk; then
		mv -f scripts/Makefile.in ${T}/Makefile.in
		sed -e "s:= bluepin:= :" \
			${T}/Makefile.in > scripts/Makefile.in
	fi
	cd ${S}/scripts
	epatch ${FILESDIR}/2.15-bluepin.patch
}

src_compile() {

	econf \
		$(use_enable cups) \
		$(use_enable alsa) \
		$(use_enable pcmcia) \
		$(use_enable gtk bluepin) \
		$(use_enable dbus) \
		--enable-usb \
		--disable-initscripts \
		--enable-obex \
		--enable-hid2hci \
		--enable-bcm203x \
		--enable-avctrl \
		--enable-dfutool \
		--localstatedir=/var \
		|| die "econf failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README ChangeLog
	# optional bluetooth utils
	cd ${S}/tools
	dosbin hcisecfilter ppporc pskey bccmd
	cd ${S}

	sed -e "s:security auto;:security user;:" \
		-i ${D}/etc/bluetooth/hcid.conf

	if use gtk; then
		sed -e "s:\(pin_helper \).*:\1/usr/bin/bluepin;:" \
			-i ${D}/etc/bluetooth/hcid.conf
	else
		sed -e "s:\(pin_helper \).*:\1/etc/bluetooth/pin-helper;:" \
			-i ${D}/etc/bluetooth/hcid.conf
	fi

	exeinto /etc/init.d
	newexe ${FILESDIR}/2.16/bluetooth.rc bluetooth

	exeinto /etc/bluetooth
	newexe ${FILESDIR}/2.10-r1/pin-helper.sh pin-helper
	insinto /etc/bluetooth
	newins ${FILESDIR}/2.10-r1/pin pin
	fperms 0600 /etc/bluetooth/pin

	insinto /etc/conf.d
	newins ${S}/scripts/bluetooth.default bluetooth
	sed -i -e 's/^HIDD_ENABLE=.*/HIDD_ENABLE=false/' \
		-e 's/^HID2HCI_ENABLE=.*/HID2HCI_ENABLE=false/' \
		${D}/etc/conf.d/bluetooth
}

pkg_postinst() {
	einfo ""
	einfo "A startup script has been installed in /etc/init.d/bluetooth."
	einfo "RFComm devices are found in /dev/bluetooth/rfcomm/* instead of /dev/rfcomm*"
	echo
	einfo "If you need to set a default PIN, edit /etc/bluetooth/pin, and change"
	einfo "/etc/bluetooth/hcid.conf option 'pin_helper' to /etc/bluetooth/pin-helper."
	echo

	if use gtk; then
		einfo "By default, /usr/bin/bluepin will be launched on the desktop display"
		einfo "for pin number input."
	fi
	einfo ""
}
