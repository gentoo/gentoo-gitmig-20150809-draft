# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/gnome-bluetooth/gnome-bluetooth-2.32.0.ebuild,v 1.3 2010/12/16 23:23:47 eva Exp $

EAPI="3"

inherit eutils gnome2 multilib

DESCRIPTION="Fork of bluez-gnome focused on integration with GNOME"
HOMEPAGE="http://live.gnome.org/GnomeBluetooth"

LICENSE="GPL-2 LGPL-2.1"
SLOT="2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc +introspection nautilus"

COMMON_DEPEND=">=dev-libs/glib-2.25.7:2
	>=x11-libs/gtk+-2.19.1:2
	>=x11-libs/libnotify-0.4.3
	>=dev-libs/dbus-glib-0.74
	dev-libs/libunique
	nautilus? ( >=gnome-extra/nautilus-sendto-2.31.7 )"
RDEPEND="${COMMON_DEPEND}
	>=net-wireless/bluez-4.34
	app-mobilephone/obexd
	sys-fs/udev"
DEPEND="${COMMON_DEPEND}
	!!net-wireless/bluez-gnome
	app-text/gnome-doc-utils
	app-text/scrollkeeper
	dev-libs/libxml2
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext
	x11-libs/libX11
	x11-libs/libXi
	x11-proto/xproto
	doc? ( >=dev-util/gtk-doc-1.9 )"
# eautoreconf needs:
#	gnome-base/gnome-common
#	dev-util/gtk-doc-am

pkg_setup() {
	G2CONF="${G2CONF}
		$(use_enable introspection)
		$(use_enable nautilus nautilus-sendto)
		--disable-moblin
		--disable-desktop-update
		--disable-icon-update"
	DOCS="AUTHORS README NEWS ChangeLog"

	enewgroup plugdev
}

src_install() {
	gnome2_src_install
	find "${ED}"/usr/$(get_libdir)/${PN}/plugins -name "*.la" -delete \
		|| die "la file removal failed (1)"
	if use nautilus; then
		find "${ED}"/usr/$(get_libdir)/nautilus-sendto/plugins -name "*.la" -delete \
			|| die "la file removal failed (1)"
	fi

	insinto /$(get_libdir)/udev/rules.d
	doins "${FILESDIR}"/80-rfkill.rules || die "udev rules installation failed"
}

pkg_preinst() {
	gnome2_pkg_preinst
	preserve_old_lib /usr/$(get_libdir)/libgnome-bluetooth.so.7
}

pkg_postinst() {
	gnome2_pkg_postinst
	preserve_old_lib_notify /usr/$(get_libdir)/libgnome-bluetooth.so.7

	elog "Don't forget to add yourself to the plugdev group "
	elog "if you want to be able to control bluetooth transmitter."
}
