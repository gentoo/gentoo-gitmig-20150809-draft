# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/usbmidi/usbmidi-1.0.ebuild,v 1.7 2005/11/03 22:30:49 eldad Exp $

DESCRIPTION="Sets up hotplugging support for MidiMan midisport 1x1/2x2 usb devices"
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
src_install() {
	insinto /usr/share/usb/ezusbmidi
	doins ${S}/testing/MidiSport/ezusbmidi*.ihx

	insinto /etc/hotplug/usb
	doins ${FILESDIR}/ezusbmidi.usermap

	exeinto /etc/hotplug/usb
	doexe ${FILESDIR}/ezusbmidi
}

pkg_postinst() {
	einfo
	einfo "Now the firmware is installed and hotplug has been setup."
	einfo "Please unplug the midisport, then plug it back in."
	einfo "The light should start to glow, if that happens its worked."
	einfo "The midisport ports will appear as 'normal' midi ports under /dev"
	einfo
}

