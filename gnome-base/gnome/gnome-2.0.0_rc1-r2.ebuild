# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome/gnome-2.0.0_rc1-r2.ebuild,v 1.1 2002/06/21 04:06:33 spider Exp $

S=${WORKDIR}
DESCRIPTION="GNOME 2.0 - merge this package to merge the Gnome2 desktop"
HOMEPAGE="http://www.gnome.org/"

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

RDEPEND="!gnome-base/gnome-core
	>=x11-wm/metacity-2.3.987
	>=gnome-base/gnome-session-2.0.1
	>=gnome-extra/bug-buddy-2.2.0
	>=gnome-base/gdm-2.4.0.0
	>=media-gfx/eog-1.0.1
	>=app-editors/gedit-2.0.0
	>=gnome-extra/yelp-1.0.1
	>=gnome-base/nautilus-2.0.0-r1
	>=x11-terms/gnome-terminal-2.0.0
	>=gnome-base/gnome-applets-2.0.0
	>=gnome-base/control-center-2.0.0
	>=gnome-extra/gnome-utils-2.0.0
	>=gnome-extra/gnome-media-2.0.0
	>=gnome-extra/gnome-system-monitor-2.0.0
	>=gnome-extra/gnome-games-2.0.1"

