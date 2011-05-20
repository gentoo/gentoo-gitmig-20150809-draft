# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bluez/bluez-4.91.ebuild,v 1.6 2011/05/20 19:26:31 maekke Exp $

EAPI="4"

inherit multilib eutils

DESCRIPTION="Bluetooth Tools and System Daemons for Linux"
HOMEPAGE="http://www.bluez.org/"

# Because of oui.txt changing from time to time without noticement, we need to supply it
# ourselves instead of using http://standards.ieee.org/regauth/oui/oui.txt directly.
# See bugs #345263 and #349473 for reference.
OUIDATE="20110330"
SRC_URI="mirror://kernel/linux/bluetooth/${P}.tar.gz
	http://dev.gentoo.org/~pacho/bluez/oui-${OUIDATE}.txt"
LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm hppa ~ppc ~ppc64 ~x86"

IUSE="alsa attrib caps +consolekit cups debug gstreamer maemo6 health old-daemons pcmcia pnat test-programs usb"

CDEPEND="
	>=dev-libs/glib-2.14:2
	media-libs/libsndfile
	sys-apps/dbus
	>=sys-fs/udev-146[extras]
	alsa? (
		media-libs/alsa-lib[alsa_pcm_plugins_extplug,alsa_pcm_plugins_ioplug]
	)
	caps? ( >=sys-libs/libcap-ng-0.6.2 )
	cups? ( net-print/cups )
	gstreamer? (
		>=media-libs/gstreamer-0.10:0.10
		>=media-libs/gst-plugins-base-0.10:0.10
	)
	usb? ( dev-libs/libusb:1 )
"
DEPEND="${CDEPEND}
	>=dev-util/pkgconfig-0.20
	sys-devel/flex
"
RDEPEND="${CDEPEND}
	!net-wireless/bluez-libs
	!net-wireless/bluez-utils
	consolekit? ( sys-auth/consolekit )
	test-programs? (
		dev-python/dbus-python
		dev-python/pygobject:2
	)
"

DOCS=( AUTHORS ChangeLog README )

pkg_setup() {
	if ! use consolekit; then
		enewgroup plugdev
	fi
}

src_prepare() {
	if ! use consolekit; then
		# No consolekit for at_console etc, so we grant plugdev the rights
		epatch	"${FILESDIR}/bluez-plugdev.patch"
	fi

	if use cups; then
		sed -i \
			-e "s:cupsdir = \$(libdir)/cups:cupsdir = `cups-config --serverbin`:" \
			Makefile.tools Makefile.in || die
	fi
}

src_configure() {
	econf \
		$(use_enable caps capng) \
		--enable-network \
		--enable-serial \
		--enable-input \
		--enable-audio \
		--enable-service \
		$(use_enable gstreamer) \
		$(use_enable alsa) \
		$(use_enable usb) \
		--enable-tools \
		--enable-bccmd \
		--enable-dfutool \
		$(use_enable old-daemons hidd) \
		$(use_enable old-daemons pand) \
		$(use_enable old-daemons dund) \
		$(use_enable attrib) \
		$(use_enable health) \
		$(use_enable pnat) \
		$(use_enable maemo6) \
		$(use_enable cups) \
		$(use_enable test-programs test) \
		--enable-udevrules \
		--enable-configfiles \
		$(use_enable pcmcia) \
		$(use_enable debug) \
		--localstatedir=/var \
		--disable-hal
}

src_install() {
	default

	if use test-programs ; then
		cd "${S}/test"
		dobin simple-agent simple-service monitor-bluetooth
		newbin list-devices list-bluetooth-devices
		rm test-textfile.{c,o} || die # bug #356529
		for b in apitest hsmicro hsplay test-* ; do
			newbin "${b}" "bluez-${b}"
		done
		insinto /usr/share/doc/${PF}/test-services
		doins service-*

		cd "${S}"
	fi

	if use old-daemons; then
		newconfd "${FILESDIR}/conf.d-hidd" hidd
		newinitd "${FILESDIR}/init.d-hidd" hidd
		newconfd "${FILESDIR}/conf.d-dund" dund
		newinitd "${FILESDIR}/init.d-dund" dund
	fi

	insinto /etc/bluetooth
	doins \
		input/input.conf \
		audio/audio.conf \
		network/network.conf \
		serial/serial.conf

	insinto /lib/udev/rules.d/
	newins "${FILESDIR}/${PN}-4.18-udev.rules" 70-bluetooth.rules
	exeinto /lib/udev/
	newexe "${FILESDIR}/${PN}-4.18-udev.script" bluetooth.sh

	newinitd "${FILESDIR}/bluetooth-init.d" bluetooth
	newconfd "${FILESDIR}/bluetooth-conf.d" bluetooth

	# Install oui.txt as requested in bug #283791 and approved by upstream
	insinto /var/lib/misc
	newins "${DISTDIR}/oui-${OUIDATE}.txt" oui.txt

	find "${ED}" -name "*.la" -delete
}

pkg_postinst() {
	udevadm control --reload-rules && udevadm trigger --subsystem-match=bluetooth

	if ! has_version "net-dialup/ppp"; then
		elog "To use dial up networking you must install net-dialup/ppp."
	fi

	if use old-daemons; then
		elog "dund and hidd init scripts were installed because you have the old-daemons"
		elog "use flag on. They are not started by default via udev so please add them"
		elog "to the required runlevels using rc-update <runlevel> add <dund/hidd>. If"
		elog "you need init scripts for the other daemons, please file requests"
		elog "to https://bugs.gentoo.org."
	fi

	if use consolekit; then
		elog "If you want to use rfcomm as a normal user, you need to add the user"
		elog "to the uucp group."
	else
		elog "Since you have the consolekit use flag disabled, you will only be able to run"
		elog "bluetooth clients as root. If you want to be able to run bluetooth clientes as "
		elog "a regular user, you need to enable the consolekit use flag for this package or"
		elog "to add the user to the plugdev group."
	fi
}
