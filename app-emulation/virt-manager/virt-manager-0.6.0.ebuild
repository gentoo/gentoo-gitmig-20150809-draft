# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/virt-manager/virt-manager-0.6.0.ebuild,v 1.1 2008/11/24 02:22:12 marineam Exp $

# Stop gnome2.eclass from doing stuff on USE=debug
GCONF_DEBUG="no"

inherit eutils gnome2

DESCRIPTION="A graphical tool for administering virtual machines such as Xen"
HOMEPAGE="http://virt-manager.org/"
SRC_URI="http://virt-manager.org/download/sources/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome-keyring"
RDEPEND=">=dev-python/pygtk-1.99.12
	>=app-emulation/libvirt-0.4.5
	>=dev-libs/libxml2-2.6.23
	>=app-emulation/virtinst-0.400.0
	>=gnome-base/librsvg-2
	>=x11-libs/vte-0.12.2
	>=net-libs/gtk-vnc-0.3.4
	dev-python/dbus-python
	dev-python/libgnome-python
	gnome-keyring? ( dev-python/gnome-keyring-python )"
DEPEND="${RDEPEND}"

pkg_setup() {
	if ! built_with_use dev-libs/libxml2 python; then
		local msg="You must install libxml2 with USE=python."
		eerror "$msg"
		die "$msg"
	fi

	if ! built_with_use x11-libs/vte python; then
		local msg="You must install vte with USE=python."
		eerror "$msg"
		die "$msg"
	fi

	if ! built_with_use net-libs/gtk-vnc python; then
		local msg="You must install gtk-vnc with USE=python."
		eerror "$msg"
		die "$msg"
	fi
}
