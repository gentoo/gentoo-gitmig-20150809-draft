# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/virt-viewer/virt-viewer-0.4.2.ebuild,v 1.3 2012/01/19 20:20:39 cardoe Exp $

EAPI=4

inherit eutils gnome2

DESCRIPTION="Graphical console client for connecting to virtual machines"
HOMEPAGE="http://virt-manager.org/"
SRC_URI="http://virt-manager.org/download/sources/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk3 nsplugin sasl spice +vnc"
RDEPEND=">=app-emulation/libvirt-0.6.0
	>=dev-libs/libxml2-2.6.0:2
	gtk3? ( x11-libs/gtk+:3 )
	!gtk3? ( >=x11-libs/gtk+-2.10.0:2
			>=gnome-base/libglade-2.6.0:2.0 )
	nsplugin? ( >=dev-libs/nspr-4.0.0
				>=net-libs/xulrunner-1.9.1:1.9
				>=x11-libs/gtk+-2.10.0:2
				>=gnome-base/libglade-2.6.0:2.0 )
	spice? ( >=net-misc/spice-gtk-0.6[sasl?,gtk3?] )
	vnc? ( >=net-libs/gtk-vnc-0.4.3 )"
DEPEND="${RDEPEND}"

pkg_pretend() {
	if ! use spice && ! use vnc; then
		eerror "You must have USE=vnc or USE=spice enabled."
		die "You must have USE=vnc or USE=spice enabled."
	fi
}

pkg_setup() {
	G2CONF="$(use_enable nsplugin plugin) $(use_with spice spice-gtk)"
	G2CONF="${G2CONF} $(use_with vnc gtk-vnc)"
	use gtk3 && G2CONF="${G2CONF} --with-gtk=3.0"
	use gtk3 || G2CONF="${G2CONF} --with-gtk=2.0"
}
