# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome/gnome-2.4.1_p1.ebuild,v 1.12 2004/02/05 18:17:44 foser Exp $

S=${WORKDIR}
DESCRIPTION="Meta package for the GNOME desktop."
HOMEPAGE="http://www.gnome.org/"
LICENSE="as-is"
SLOT="2.0"

IUSE="cdr dvdr doc accessibility samba"

# when unmasking for an arch
# double check none of the deps are still masked !

# NOTE TO DEVS : 
# THIS IS AN UPDATE TRACKING PACK ONLY MEANT FOR GNOME DEVS
# NO NEED TO ADD ARCH KEYWORDS, THOSE WILL BE ADDED IN REGULAR RELEASES
KEYWORDS="~x86"

#  Note to developers:
#  This is a wrapper for the complete Gnome2 desktop,
#  This means all components that a user expects in Gnome2 are present
#  please do not reduce this list further unless
#  dependencies pull in what you remove.
#  With "emerge gnome" a user expects the full "standard" distribution 
#  of Gnome and should be provided with that, consider only 
#  installing the parts needed for smaller installations.

RDEPEND="!gnome-base/gnome-core

	>=dev-libs/glib-2.2.3
	>=dev-libs/atk-1.4.1
	>=x11-libs/pango-1.2.5-r1
	>=x11-libs/gtk+-2.2.4-r1

	>=gnome-base/gconf-2.4.0.1

	>=dev-libs/libIDL-0.8.2
	>=gnome-base/ORBit2-2.8.3

	>=media-libs/audiofile-0.2.4
	>=media-sound/esound-0.2.32
	>=gnome-base/gail-1.4.1
	>=gnome-base/gnome-mime-data-2.4.1
	>=gnome-base/gnome-vfs-2.4.2
	>=media-libs/libart_lgpl-2.3.16

	>=gnome-base/libbonobo-2.4.3
	>=gnome-base/libbonoboui-2.4.3
	>=gnome-base/libglade-2.0.1
	>=gnome-base/libgnome-2.4
	>=gnome-base/libgnomecanvas-2.4
	>=gnome-base/libgnomeui-2.4.0.1

	>=dev-libs/libxml2-2.6.4
	>=dev-libs/libxslt-1.1.2

	>=gnome-extra/acme-2.4.2
	>=gnome-extra/bug-buddy-2.4.1

	>=gnome-base/control-center-2.4

	>=gnome-base/eel-2.4.1
	>=gnome-base/nautilus-2.4.1-r2
	>=gnome-extra/nautilus-media-0.3.3.1

	>=media-gfx/eog-2.4.1
	>=net-www/epiphany-1.0.7
	>=app-arch/file-roller-2.4.4
	>=gnome-extra/gcalctool-4.3.16
	>=gnome-extra/gconf-editor-2.4
	>=gnome-base/gdm-2.4.1.7
	>=app-editors/gedit-2.4.1
	>=app-text/ggv-2.4.0.2
	>=app-text/gpdf-0.111
	>=gnome-base/gnome-applets-2.4.1-r2
	>=gnome-base/gnome-desktop-2.4.1.1
	>=gnome-extra/gnome-games-2.4.1.1

	>=x11-themes/gtk-engines-2.2
	>=x11-themes/gnome-icon-theme-1.0.9
	>=x11-themes/gnome-themes-2.4.1

	>=gnome-extra/gnome-media-2.4.1.1
	>=gnome-base/gnome-panel-2.4.2
	>=gnome-base/gnome-session-2.4.2
	>=gnome-extra/gnome-system-monitor-2.4
	>=x11-terms/gnome-terminal-2.4.2
	>=gnome-extra/gnome2-user-docs-2.4.1
	>=gnome-extra/gnome-utils-2.4.1
	>=media-libs/gstreamer-0.6.4
	>=media-libs/gst-plugins-0.6.4
	>=x11-libs/gtksourceview-0.7-r1
	>=gnome-extra/gucharmap-1.2
	>=gnome-base/libgnomeprint-2.4.2
	>=gnome-base/libgnomeprintui-2.4.2
	=gnome-extra/libgtkhtml-2.4*
	>=gnome-base/libgtop-2.0.8
	>=gnome-base/librsvg-2.4
	>=x11-libs/libwnck-2.4.0.1-r1
	>=x11-wm/metacity-2.6.3
	>=gnome-extra/zenity-1.8

	>=x11-libs/startup-notification-0.5

	>=gnome-extra/yelp-2.4.2
	>=x11-libs/vte-0.11.10

	>=app-text/scrollkeeper-0.3.12
	>=dev-util/pkgconfig-0.15
	>=dev-util/intltool-0.27.2

	cdr? ( >=gnome-extra/nautilus-cd-burner-0.6.1 )
	dvdr? ( >=gnome-extra/nautilus-cd-burner-0.6.1 )
	doc? ( >=dev-util/gtk-doc-1.1 )

	accessibility? ( >=gnome-extra/libgail-gnome-1.0.2
		>=gnome-extra/at-spi-1.3.9
		>=gnome-extra/gnome-speech-0.2.8
		>=gnome-extra/gnome-mag-0.10.4
		>=gnome-extra/gok-0.8.4
		>=gnome-extra/gnopernicus-0.7.1 )

	samba? ( >=gnome-extra/gnome-vfs-extras-0.99.11 )"

pkg_postinst () {

	einfo "note that to change windowmanager to metacity do: "
	einfo " export WINDOW_MANAGER=\"/usr/bin/metacity\""
	einfo "of course this works for all other window managers as well"

}
