# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome/gnome-2.4_rc1.ebuild,v 1.3 2003/09/08 05:04:45 msterret Exp $

S=${WORKDIR}
DESCRIPTION="Meta package for the GNOME desktop."
HOMEPAGE="http://www.gnome.org/"
LICENSE="as-is"
SLOT="2.0"

# when unmasking for an arch
# double check none of the deps are still masked !
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~hppa ~amd64"

#  Note to developers:
#  This is a wrapper for the complete Gnome2 desktop,
#  This means all components that a user expects in Gnome2 are present
#  please do not reduce this list further unless
#  dependencies pull in what you remove.
#  With "emerge gnome" a user expects the full "standard" distribution of Gnome and should be provided with that, consider only installing the parts needed for smaller installations.

RDEPEND="!gnome-base/gnome-core

	>=gnome-base/gconf-2.3.3
	>=gnome-base/ORBit2-2.8
	>=dev-libs/atk-1.4
	>=media-libs/audiofile-0.2.3
	>=media-sound/esound-0.2.32
	>=gnome-base/gail-1.4
	>=dev-libs/glib-2.2.3
	>=gnome-base/gnome-mime-data-2.3.2
	>=gnome-base/gnome-vfs-2.3.90
	>=x11-libs/gtk+-2.2.4
	>=media-libs/libart_lgpl-2.3.15

	>=gnome-base/libbonobo-2.4
	>=gnome-base/libbonoboui-2.4
	>=gnome-base/libglade-2.0.1
	>=gnome-base/libgnome-2.4
	>=gnome-base/libgnomecanvas-2.4
	>=gnome-base/libgnomeui-2.4

	>=dev-libs/libxml2-2.5.10
	>=dev-libs/libxslt-1.0.32
	>=x11-libs/pango-1.2.5


	>=gnome-extra/acme-2.0.6
	>=gnome-extra/bug-buddy-2.4

	>=gnome-base/control-center-2.3.6

	>=gnome-base/eel-2.3.90
	>=gnome-base/nautilus-2.3.90
	>=gnome-extra/nautilus-media-0.3.3

	>=media-gfx/eog-2.3.90
	>=net-www/epiphany-0.9.3
	>=app-arch/file-roller-2.3.6
	>=gnome-extra/gcalctool-4.3.2
	>=gnome-extra/gconf-editor-2.4
	>=gnome-base/gdm-2.2
	>=app-editors/gedit-2.3.5
	>=app-text/ggv-2.3.99
	>=app-text/gpdf-0.106
	>=gnome-base/gnome-applets-2.3.90
	>=gnome-base/gnome-desktop-2.3.90
	>=gnome-extra/gnome-games-2.3.90
	>=x11-themes/gnome-icon-theme-1.0.8
	>=gnome-extra/gnome-media-2.3.90
	>=gnome-base/gnome-panel-2.3.90
	>=gnome-base/gnome-session-2.3.90
	>=gnome-extra/gnome-system-monitor-2.3.1
	>=x11-terms/gnome-terminal-2.3.2
	>=x11-themes/gnome-themes-2.3.4
	>=gnome-extra/gnome2-user-docs-2.0.6
	>=gnome-extra/gnome-utils-2.3.90
	>=media-libs/gstreamer-0.6.3
	>=media-libs/gst-plugins-0.6.3
	>=x11-libs/gtksourceview-0.6
	>=gnome-extra/gucharmap-0.9
	>=gnome-extra/libgail-gnome-1.0.2
	>=gnome-base/libgnomeprint-2.3.1
	>=gnome-base/libgnomeprintui-2.3.1
	=gnome-extra/libgtkhtml-2.4*
	>=gnome-base/libgtop-2.0.4
	>=gnome-base/librsvg-2.3.1
	>=x11-libs/libwnck-2.3.1
	>=x11-wm/metacity-2.5.5

	>=x11-libs/startup-notification-0.5

	>=gnome-extra/yelp-2.3.90
	>=x11-libs/vte-0.11.10"

# zenity scrollkeeper nautilus-cd-burner




#RDEPEND="!gnome-base/gnome-core
#
#	>=dev-util/intltool-0.26
#
#	>=x11-wm/metacity-2.4.55
#	>=gnome-base/gnome-session-2.2.2
#	>=gnome-extra/bug-buddy-2.2.106
#	>=gnome-base/control-center-2.2.2
#	>=gnome-base/gdm-2.4.1.6
#	>=media-gfx/eog-2.2.2
#	>=app-editors/gedit-2.2.2
#	>=gnome-extra/yelp-2.2.3
#	>=gnome-base/nautilus-2.2.4
#	>=x11-terms/gnome-terminal-2.2.2
#	>=gnome-base/gnome-applets-2.2.2
#	>=gnome-extra/gnome-utils-2.2.3
#	>=gnome-extra/gnome-system-monitor-2.0.5
#	>=gnome-extra/gnome-games-2.2.1
#	>=gnome-extra/gconf-editor-0.4.1
#	>=gnome-extra/gnome2-user-docs-2.0.6
#	>=gnome-base/gnome-mime-data-2.2.1
#
#	>=x11-libs/gtk+-2.2.1-r1
#	>=x11-libs/pango-1.2.3
#	>=dev-libs/atk-1.2.4
#	>=dev-libs/glib-2.2.2
#
#	>=gnome-base/ORBit2-2.6.3
#	>=gnome-base/bonobo-activation-2.2.4
#	>=gnome-base/libbonobo-2.2.3
#	>=gnome-base/libbonoboui-2.2.4

#	>=gnome-base/gconf-2.2.1
#	>=gnome-base/gnome-panel-2.2.2.2
#	>=gnome-base/gnome-desktop-2.2.2
#	>=gnome-base/gnome-vfs-2.2.5
#	>=gnome-base/librsvg-2.2.5
#	>=gnome-base/libgnome-2.2.3
#	>=gnome-base/libgnomeui-2.2.2
#	>=gnome-base/libgnomecanvas-2.2.1
#	>=gnome-base/libglade-2.0.1
#	>=gnome-base/libgtop-2.0.3
#
#	>=net-libs/linc-1.0.3
#
#	>=x11-libs/libwnck-2.2.2
#	>=gnome-base/libgnomeprint-2.2.1.3
#	>=gnome-base/libgnomeprintui-2.2.1.3
#	>=gnome-extra/libgail-gnome-1.0.2
#
#	>=x11-themes/gnome-icon-theme-1.0.6
#	>=x11-themes/gnome-themes-2.2.2
#
#	>=app-arch/file-roller-2.2.5
#	>=gnome-extra/acme-2.0.6
#	>=app-text/ggv-2.0.1
#
#	!hppa? ( !alpha? (
#		>=gnome-extra/gnome-media-2.2.2
#		>=gnome-extra/nautilus-media-0.2.2
#		>=media-libs/gst-plugins-0.6.2-r1
#		>=media-libs/gstreamer-0.6.2 ) )"

# The packages marked !alpha above don't build yet on alpha.  We
# haven't given up, but there's no reason for them to hold up Gnome
# 2.2 for alpha.

pkg_postinst () {
	einfo "note that to change windowmanager to metacity do: "
	einfo " export WINDOW_MANAGER=\"/usr/bin/metacity\""
	einfo "of course this works for all other window managers as well"
}
