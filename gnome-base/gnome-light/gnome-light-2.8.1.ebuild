# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-light/gnome-light-2.8.1.ebuild,v 1.2 2005/03/29 17:32:19 squash Exp $

S=${WORKDIR}
DESCRIPTION="Meta package for the GNOME desktop, merge this package to install"
HOMEPAGE="http://www.gnome.org/"
LICENSE="as-is"
SLOT="2.0"
IUSE=""

# when unmasking for an arch
# double check none of the deps are still masked !
KEYWORDS="x86 ~ppc ~amd64 sparc"

#  Note to developers:
#  This is a wrapper for the 'light' Gnome2 desktop,
#  This should only consist of the bare minimum of libs/apps needed
#  It is basicly the gnome-base/gnome without all extra apps

#  This is currently in it's test phase, if you feel like some dep
#  should be added or removed from this pack file a bug to
#  gnome@gentoo.org on bugs.gentoo.org

#	>=media-gfx/eog-2.2.1

RDEPEND="!gnome-base/gnome-core
	!gnome-base/gnome

	>=dev-libs/glib-2.4.8
	>=dev-libs/atk-1.8
	>=x11-libs/gtk+-2.4.13-r1
	>=x11-libs/pango-1.6

	>=gnome-base/gnome-mime-data-2.4.2
	>=x11-misc/shared-mime-info-0.14

	>=gnome-base/orbit-2.12

	>=gnome-base/gconf-2.8.1-r1
	>=gnome-base/gnome-vfs-2.8.3-r1

	>=gnome-base/libbonobo-2.8
	>=gnome-base/libbonoboui-2.8
	>=gnome-base/libgnome-2.8
	>=gnome-base/libgnomeui-2.8
	>=gnome-base/libgnomecanvas-2.8
	>=gnome-base/libglade-2.4

	>=gnome-base/control-center-2.8.1-r1

	>=gnome-base/eel-2.8.2
	>=gnome-base/nautilus-2.8.2-r1

	>=gnome-base/gnome-session-2.8.1
	>=gnome-base/gnome-desktop-2.8.1
	>=gnome-base/gnome-panel-2.8.2

	>=x11-themes/gnome-icon-theme-2.8
	>=x11-themes/gnome-themes-2.8.1

	>=x11-terms/gnome-terminal-2.8

	>=gnome-base/librsvg-2.8.1
	>=x11-libs/libwnck-2.8.1
	>=x11-wm/metacity-2.8.6-r1

	>=gnome-extra/yelp-2.6.4"

pkg_postinst () {

	einfo "note that to change windowmanager to metacity do: "
	einfo " export WINDOW_MANAGER=\"/usr/bin/metacity\""
	einfo "of course this works for all other window managers as well"
	einfo ""
	ewarn "Remember, this meta package is experimental !"
	einfo ""
	einfo "Use gnome-base/gnome for the full GNOME Desktop"
	einfo "as released by the GNOME team."

}
