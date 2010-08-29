# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-light/gnome-light-2.28.2.ebuild,v 1.8 2010/08/29 17:34:28 armin76 Exp $

EAPI="2"

S=${WORKDIR}
DESCRIPTION="Meta package for the GNOME desktop, merge this package to install"
HOMEPAGE="http://www.gnome.org/"
LICENSE="as-is"
SLOT="2.0"
IUSE="+automount"

# when unmasking for an arch
# double check none of the deps are still masked !
KEYWORDS="alpha amd64 arm ia64 ~ppc ~ppc64 sparc x86 ~x86-freebsd ~amd64-linux ~x86-linux ~x86-solaris"

#  Note to developers:
#  This is a wrapper for the 'light' Gnome2 desktop,
#  This should only consist of the bare minimum of libs/apps needed
#  It is basicly the gnome-base/gnome without all extra apps

#  This is currently in it's test phase, if you feel like some dep
#  should be added or removed from this pack file a bug to
#  gnome@gentoo.org on bugs.gentoo.org

#	>=media-gfx/eog-2.28.1

RDEPEND="!gnome-base/gnome

	>=dev-libs/glib-2.22.4
	>=x11-libs/gtk+-2.18.7
	>=dev-libs/atk-1.28.0
	>=x11-libs/pango-1.26.2

	>=gnome-base/orbit-2.14.17

	>=x11-libs/libwnck-2.28.0
	>=x11-wm/metacity-2.28.1

	>=gnome-base/gconf-2.28.0

	>=gnome-base/libbonobo-2.24.2
	>=gnome-base/libbonoboui-2.24.2
	>=gnome-base/libgnome-2.28.0
	>=gnome-base/libgnomeui-2.24.2
	>=gnome-base/libgnomecanvas-2.26.0
	>=gnome-base/libglade-2.6.4

	>=gnome-base/gnome-settings-daemon-2.28.1
	>=gnome-base/gnome-control-center-2.28.1

	>=gnome-base/nautilus-2.28.4

	>=gnome-base/gnome-desktop-2.28.2
	>=gnome-base/gnome-session-2.28.0
	>=gnome-base/gnome-panel-2.28.0

	>=x11-themes/gnome-icon-theme-2.28.0
	>=x11-themes/gnome-themes-2.28.1

	>=x11-terms/gnome-terminal-2.28.2

	>=gnome-base/librsvg-2.26.0

	>=gnome-extra/yelp-2.28.1"
DEPEND=""
PDEPEND=">=gnome-base/gvfs-1.4.3
	automount? ( >=gnome-base/gvfs-1.4.3[gdu] )"

pkg_postinst () {
# FIXME: Rephrase to teach about using different WMs instead, as metacity is the default anyway
# FIXME: but first check WINDOW_MANAGER is still honored in 2.24. gnome-session-2.24 might have lost
# FIXME: support for it, but we don't ship with gnome-session-2.24 yet
#	elog "Note that to change windowmanager to metacity do: "
#	elog " export WINDOW_MANAGER=\"/usr/bin/metacity\""
#	elog "of course this works for all other window managers as well"
#	elog

	elog "Use gnome-base/gnome for the full GNOME Desktop"
	elog "as released by the GNOME team."
}
