# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/usbmidi/usbmidi-1.0.ebuild,v 1.10 2007/06/26 02:16:23 mr_bones_ Exp $

inherit linux-info

DESCRIPTION="hotplugging support for MidiMan midisport 1x1/2x2 usb devices on 2.4 kernels"
HOMEPAGE="http://homepage3.nifty.com/StudioBreeze/software/usbmidi-e.html"
SRC_URI="http://homepage3.nifty.com/StudioBreeze/software/bin/usbmidi-20030126.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND=""

RDEPEND="sys-apps/hotplug
	sys-apps/ezusb2131
	sys-apps/fxload"

S="${WORKDIR}/usbmidi-20030126"

pkg_setup() {
	if ! kernel_is 2 4 ; then
		eerror "This ebuild is only for 2.4.x kernels."
		die "Use in-kernel USB MIDI support instead."
	fi
}

src_install() {
	insinto /usr/share/usb/ezusbmidi
	doins ${S}/testing/MidiSport/ezusbmidi*.ihx

	insinto /etc/hotplug/usb
	doins ${FILESDIR}/ezusbmidi.usermap

	exeinto /etc/hotplug/usb
	doexe ${FILESDIR}/ezusbmidi
}

pkg_postinst() {
	elog
	elog "Now the firmware is installed and hotplug has been setup."
	elog "Please unplug the midisport, then plug it back in."
	elog "The light should start to glow, if that happens its worked."
	elog "The midisport ports will appear as 'normal' midi ports under /dev"
	elog
}
