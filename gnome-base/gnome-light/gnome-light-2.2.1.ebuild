# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-light/gnome-light-2.2.1.ebuild,v 1.2 2003/08/13 03:20:00 obz Exp $

S=${WORKDIR}
DESCRIPTION="Meta package for the GNOME desktop, merge this package to install"
HOMEPAGE="http://www.gnome.org/"
LICENSE="as-is"
SLOT="2.0"

# when unmasking for an arch
# double check none of the deps are still masked !
KEYWORDS="~x86"

#  Note to developers:
#  This is a wrapper for the 'light' Gnome2 desktop,
#  This should only consist of the bare minimum of libs/apps needed
#  It is basicly the gnome-base/gnome without all extra apps

#  This is currently in it's test phase, if you feel like some dep
#  should be added or removed from this pack file a bug to 
#  gnome@gentoo.org on bugs.gentoo.org

#	>=media-gfx/eog-2.2.1

RDEPEND="!gnome-base/gnome-core
	>=x11-wm/metacity-2.4.34
	>=gnome-base/gnome-session-2.2.1
	>=gnome-base/gdm-2.4.1.3
	>=gnome-base/nautilus-2.2.2
	>=x11-terms/gnome-terminal-2.2.1
	>=gnome-base/control-center-2.2.1
	>=gnome-base/gnome-mime-data-2.2.0
	>=gnome-extra/yelp-2.2.2
	
	>=x11-libs/gtk+-2.2.1
	>=x11-libs/pango-1.2.1
	>=dev-libs/atk-1.2.2
	>=dev-libs/glib-2.2.1
	>=gnome-base/gconf-2.2
	>=gnome-base/gnome-panel-2.2.0.1-r1
	>=gnome-base/gnome-desktop-2.2.1
	>=gnome-base/gnome-vfs-2.2.3
	>=gnome-base/libbonobo-2.2.1
	>=gnome-base/libbonoboui-2.2.0.1
	>=gnome-base/libgnome-2.2.0.1
	>=gnome-base/libgnomecanvas-2.2.0.2
	>=gnome-base/libgnomeui-2.2.0.1
	>=gnome-base/bonobo-activation-2.2.1.1
	>=gnome-base/librsvg-2.2.4
	>=net-libs/linc-1.0.1
	>=gnome-base/libglade-2.0.1
	>=x11-libs/libwnck-2.2.1
	>=gnome-base/ORBit2-2.6.1
	>=x11-themes/gnome-icon-theme-1.0.1
	>=x11-themes/gnome-themes-2.2.1"

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
