# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gsynaptics/gsynaptics-0.9.16.ebuild,v 1.1 2009/09/21 06:59:09 pva Exp $

GCONF_DEBUG="no"

inherit eutils gnome2

DESCRIPTION="A GTK+ based configuration utility for the synaptics driver"
HOMEPAGE="http://gsynaptics.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/${PN}/38463/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-libs/glib-2.10
	>=x11-libs/gtk+-2.6.0
	>=gnome-base/gconf-2.0
	>=gnome-base/libglade-2"
DEPEND="${DEPEND}
	>=dev-util/pkgconfig-0.19
	app-text/gnome-doc-utils
	>=dev-util/intltool-0.35.5
	test? ( ~app-text/docbook-xml-dtd-4.1.2 )"

DOCS="AUTHORS ChangeLog NEWS README TODO"

src_unpack() {
	gnome2_src_unpack

	# Fix ?
	epatch "${FILESDIR}/${PN}-0.9.13-CoastingSpeedThreshold.patch"

	# Ubuntu/Debian patch stack. See bug #248939 and
	# http://patches.ubuntu.com/by-release/extracted/debian/g/gsynaptics/
	epatch "${FILESDIR}/${PN}-0.9.14-do-not-set-zero.patch"
	epatch "${FILESDIR}/${PN}-0.9.14-dot-fixes.patch"
	epatch "${FILESDIR}/${PN}-0.9.14-fix-docbook.patch"
}

pkg_postinst() {
	gnome2_pkg_postinst

	echo
	elog "SHMConfig option of the synaptics X11 driver must be enabled to allow"
	elog "${PN} to configure touchpad: if hal is used to configure input devices"
	elog "copy /usr/share/hal/fdi/policy/10osvendor/11-x11-synaptics.fdi into"
	elog "/etc/hal/fdi/policy/, uncomment relevant setting there and restart"
	elog "hal. In case xorg.conf is used ensure that the following line is in"
	elog "the InputDevice section:"
	elog
	elog 'Option "SHMConfig" "on"'
	elog
	elog "To restore touchpad settings the next time you log into GNOME it's"
	elog "necessary to add gsynaptics-init to your session:"
	elog "Desktop -> Preferences -> Sessions -> Start Programs -> Add"
	echo
	ewarn "SHMConfig is real SECURITY nightmare. E.g. it allows anyone with access"
	ewarn "to the system to click on arbitrary points of the screen."
	ewarn "This is the reason for the deprecation of ${PN} (see homepage)."
# gnome-extra/gpointing-device-settings is not working here, so it's not in the
# tree. I've put it in overlay for now and contacted upstream...
#	ewarn "Use gnome-extra/gpointing-device-settings instread as it uses XInput"
#	ewarn "properties and doesn't need SHMConfig option to be set."
#	ewarn "In gnome 2.28 gnome-mouse-properties will allow to configure touchpad"
#	ewarn "settings (also trough XInput), so no additional software needed there."
}
