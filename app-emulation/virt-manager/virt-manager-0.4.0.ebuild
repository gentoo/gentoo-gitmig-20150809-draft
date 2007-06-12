# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/virt-manager/virt-manager-0.4.0.ebuild,v 1.2 2007/06/12 06:45:26 dberkholz Exp $

inherit eutils gnome2

DESCRIPTION="A graphical tool for administering virtual machines such as Xen"
HOMEPAGE="http://virt-manager.et.redhat.com/"
SRC_URI="http://virt-manager.et.redhat.com/download/sources/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND=">=dev-python/pygtk-1.99.11
	>=dev-python/gnome-python-1.99
	>=app-emulation/libvirt-0.1.4
	|| ( dev-python/dbus-python >=sys-apps/dbus-0.61 )
	>=gnome-base/gnome-keyring-0.4.9
	>=dev-python/gnome-python-desktop-2.15
	>=dev-libs/libxml2-2.6.23
	>=app-emulation/virtinst-0.103
	>=gnome-base/librsvg-2
	>=x11-libs/vte-0.12.2
	sys-apps/usermode
	dev-python/rhpl"
DEPEND="${RDEPEND}"

# Stop gnome2.eclass from doing stuff on USE=debug
GCONF_DEBUG="no"

pkg_setup() {
	if ! built_with_use --missing false sys-apps/dbus python; then
		if ! has_version dev-python/dbus-python; then
			local msg="You must install dbus with USE=python or dbus-python."
			eerror "$msg"
			die "$msg"
		fi
	fi

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
}

#src_install() {
#	emake DESTDIR="${D}" install || die "emake install failed"
#}
