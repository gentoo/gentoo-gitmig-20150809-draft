# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome/gnome-2.0.0-r2.ebuild,v 1.3 2002/08/01 11:59:02 seemant Exp $

S=${WORKDIR}
DESCRIPTION="GNOME 2.0 - merge this package to merge the Gnome2 desktop"
HOMEPAGE="http://www.gnome.org/"
LICENSE="as-is"
KEYWORDS="ppc x86"
SLOT="2.0"

#  Note to developers:
#  This is a wrapper for the complete Gnome2 desktop, 
#  This means all components that a user expects in Gnome2 are present
#  please do not reduce this list further unless 
#  dependencies pull in what you remove.
#  With "emerge gnome" a user expects the full "standard" distribution of Gnome and should be provided with that, consider only installing the parts needed for smaller installations.

# Metacity was choosen as the default window manager because of sawfish's long time of non-working state.

# eog is installed to provide with image previews in nautilus.

# gedit is a core example of Gnome2 platform

# applets will pull in the gnome-panel

# after the blank line are the "complete" list we use for gnome2 betas

RDEPEND="!gnome-base/gnome-core
	>=x11-wm/metacity-2.3.987-r2
	>=gnome-base/gnome-session-2.0.2
	>=gnome-extra/bug-buddy-2.2.0
	>=gnome-base/gdm-2.4.0.1
	>=media-gfx/eog-1.0.1-r2
	>=app-editors/gedit-2.0.1-r1
	>=gnome-extra/yelp-1.0.1
	>=gnome-base/nautilus-2.0.0-r3
	>=x11-terms/gnome-terminal-2.0.0-r1
	>=gnome-base/gnome-applets-2.0.0-r1
	>=gnome-base/control-center-2.0.0
	>=gnome-extra/gnome-utils-2.0.0
	>=gnome-extra/gnome-media-2.0.0
	>=gnome-extra/gnome-system-monitor-2.0.0-r1
	>=gnome-extra/gnome-games-2.0.1
	>=gnome-extra/gconf-editor-0.2
	gnome-extra/gnome2-user-docs


	>=x11-libs/gtk+-2.0.5
	>=x11-libs/pango-1.0.3
	>=dev-libs/atk-1.0.2
	>=dev-libs/glib-2.0.4
	>=gnome-base/eel-2.0.0-r1
	>=gnome-base/gnome-panel-2.0.2
	>=gnome-base/gnome-desktop-2.0.3
	>=gnome-base/gnome-vfs-2.0.1
	>=gnome-base/libbonoboui-2.0.0
	>=gnome-base/libbonobo-2.0.0
	>=gnome-base/librsvg-2.0.0-r1
	>=gnome-base/libgnome-2.0.1-r1
	>=gnome-base/libgnomecanvas-2.0.1
	>=gnome-base/libgnomeui-2.0.1
	>=gnome-base/bonobo-activation-1.0.2
	>=net-libs/linc-0.5.0-r1
	>=x11-libs/libzvt-2.0.1
	>=gnome-base/libglade-2.0.0
	>=x11-libs/libwnck-0.14-r1
	>=gnome-base/ORBit2-2.4.0-r1"
pkg_postinst () {
	einfo "note that to change windowmanager to metacity do: "
	einfo " export WINDOW_MANAGER=\"/usr/bin/metacity\""
	einfo "of course this works for all other window managers as well"
	
}
