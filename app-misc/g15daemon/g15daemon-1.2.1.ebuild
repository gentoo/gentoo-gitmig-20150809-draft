# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/g15daemon/g15daemon-1.2.1.ebuild,v 1.1 2006/10/04 18:50:38 jokey Exp $

inherit linux-info eutils

DESCRIPTION="G15daemon takes control of the G15 keyboard, through the linux kernel uinput device driver"
HOMEPAGE="http://g15daemon.sourceforge.net/"
SRC_URI="mirror://sourceforge/g15daemon/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/libusb
	dev-libs/libdaemon
	dev-libs/libg15"

uinput_check() {
	ebegin "Checking for uinput support"
	linux_chkconfig_present INPUT_UINPUT
	eend $?

	if [[ $? -ne 0 ]] ; then
		eerror "To use g15daemon, you need to compile your kernel with uinput support."
		eerror "Please enable uinput support in your kernel config, found at:"
		eerror
		eerror "Device Drivers -> Input Device ... -> Miscellaneous devices -> User level driver support."
		eerror
		eerror "Once enabled, you should have the /dev/input/uinput device."
		eerror "g15daemon will not work without the uinput device."
		die "INPUT_UINPUT support not detected!"
	fi
}

pkg_setup() {
	linux-info_pkg_setup
	uinput_check
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS NEWS README TODO ChangeLog

	insinto /usr/share/${PN}/contrib
	doins contrib/xmodmaprc
	doins contrib/xmodmap.sh
	doins contrib/testbindings.pl

	newinitd ${FILESDIR}/g15daemon-${PV}.rc g15daemon
}

pkg_postinst() {
	einfo "To use g15daemon, you need to add g15daemon to the default runlevel."
	einfo "This can be done with:"
	einfo "# /sbin/rc-update add g15daemon default"
	einfo ""
	einfo "To have all new keys working in X11,"
	einfo "you'll need create a specific xmodmap in your home directory"
	einfo "or edit the existant one."
	einfo ""
	einfo "create the xmodmap:"
	einfo "cp /usr/share/g15daemon/contrib/xmodmaprc ~/.Xmodmap"
	einfo ""
	einfo "adding keycodes to an existing xmodmap:"
	einfo "cat /usr/share/g15daemon/contrib/xmodmaprc >> ~/.Xmodmap"
	einfo ""
}
