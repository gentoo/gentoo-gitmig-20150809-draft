# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-volume-manager/gnome-volume-manager-1.5.15-r2.ebuild,v 1.8 2006/08/18 23:25:44 kloeri Exp $

inherit gnome2 eutils autotools

DESCRIPTION="Daemon that enforces volume-related policies"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE="crypt debug doc"

RDEPEND="gnome-base/nautilus
	sys-devel/gettext
	>=gnome-base/libgnomeui-2.1.5
	>=sys-apps/dbus-0.31
	>=sys-apps/hal-0.5.6
	>=x11-libs/gtk+-2.6
	>=gnome-base/libglade-2
	>=gnome-base/gconf-2
	>=gnome-base/control-center-2.0
	gnome-base/gnome-mime-data
	gnome-base/gnome-mount"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.27.2"

DOCS="AUTHORS ChangeLog README HACKING NEWS TODO"

pkg_setup() {
	G2CONF="${G2CONF} \
			$(use_enable crypt) \
			$(use_enable debug) \
			$(use_enable doc)"

	# FIXME: We should be more intelligent about disabling multiuser support
	# (like enable it when pam_console is available?). For now, this is a
	# slightly nicer solution than applying ${PN}-1.5.9-no-pam_console.patch
	G2CONF="${G2CONF} --disable-multiuser"
}

src_unpack() {
	gnome2_src_unpack

	# Hard disable the libnotify support as it was not tested sufficiently.
	# Drop this patch with the 2.16 cycle
	epatch ${FILESDIR}/${PN}-1.5.15-no-libnotify.patch

	# disable dvd playback in totem since it doesn't work.
	epatch "${FILESDIR}"/disable-totem-dvd-autoplay.patch

	eautoreconf
}

pkg_postinst() {
	gnome2_pkg_postinst

	einfo "To start the gnome-volume-manager daemon you need to configure"
	einfo "it through it's preferences capplet. Also the HAL daemon (hald)"
	einfo "needs to be running or it will shut down."
}
