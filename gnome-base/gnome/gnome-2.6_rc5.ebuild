# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome/gnome-2.6_rc5.ebuild,v 1.1 2004/03/31 23:07:55 foser Exp $

S=${WORKDIR}
DESCRIPTION="Meta package for the GNOME desktop."
HOMEPAGE="http://www.gnome.org/"
LICENSE="as-is"
SLOT="2.0"

IUSE="cdr dvdr doc accessibility"
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

	>=dev-libs/glib-2.4
	>=dev-libs/atk-1.6
	>=x11-libs/gtk+-2.4
	>=x11-libs/pango-1.4

	>=dev-libs/libxml2-2.6.7
	>=dev-libs/libxslt-1.1.4

	>=x11-libs/libxklavier-1
	>=media-libs/audiofile-0.2.5
	>=media-sound/esound-0.2.34
	>=gnome-base/gnome-mime-data-2.4.0
	>=media-libs/libart_lgpl-2.3.16

	>=dev-libs/libIDL-0.8.3
	>=gnome-base/ORBit2-2.10

	>=gnome-base/gconf-2.6
	>=gnome-base/gnome-keyring-0.2
	>=gnome-base/gnome-vfs-2.6

	>=gnome-base/libbonobo-2.6
	>=gnome-base/libbonoboui-2.6
	>=gnome-base/libgnome-2.6
	>=gnome-base/libgnomeui-2.6
	>=gnome-base/libgnomecanvas-2.6
	>=gnome-base/libglade-2.3.6

	>=gnome-extra/bug-buddy-2.6
	>=gnome-base/control-center-2.6.0.2

	>=gnome-base/eel-2.6
	>=gnome-base/nautilus-2.6

	>=media-libs/gstreamer-0.8
	>=media-libs/gst-plugins-0.8-r1
	>=gnome-extra/gnome-media-2.6
	>=gnome-extra/nautilus-media-0.8

	>=media-gfx/eog-2.6
	>=net-www/epiphany-1.2.2
	>=app-arch/file-roller-2.6
	>=gnome-extra/gcalctool-4.3.51
	>=gnome-extra/gconf-editor-2.6
	>=gnome-base/gdm-2.4.4.7
	>=app-editors/gedit-2.6

	>=app-text/ggv-2.6
	>=app-text/gpdf-0.131

	>=gnome-base/gnome-session-2.6
	>=gnome-base/gnome-desktop-2.6.0.1
	>=gnome-base/gnome-applets-2.6
	>=gnome-base/gnome-panel-2.6

	>=x11-themes/gnome-icon-theme-1.2
	>=x11-themes/gnome-themes-2.6

	>=x11-terms/gnome-terminal-2.6
	>=gnome-extra/gnome2-user-docs-2.6.0.1

	>=x11-libs/gtksourceview-1
	>=gnome-extra/gucharmap-1.4.1
	>=gnome-base/libgnomeprint-2.6
	>=gnome-base/libgnomeprintui-2.6
	=gnome-extra/libgtkhtml-2.6*

	>=gnome-extra/gnome-utils-2.6
	>=gnome-extra/gnome-games-2.6.0.1

	>=gnome-base/libgtop-2.5.2
	>=gnome-extra/gnome-system-monitor-2.6

	>=gnome-base/librsvg-2.6.4
	>=x11-libs/libwnck-2.6.0.1
	>=x11-wm/metacity-2.8

	>=x11-libs/startup-notification-0.5

	>=gnome-extra/yelp-2.6
	>=x11-libs/vte-0.11.10
	>=gnome-extra/zenity-2.6.0
	>=net-analyzer/gnome-netstatus-2.6.0.1

	cdr? ( >=gnome-extra/nautilus-cd-burner-2.6.0 )
	dvdr? ( >=gnome-extra/nautilus-cd-burner-2.6.0 )

	accessibility? (
		>=gnome-extra/libgail-gnome-1.0.3
		>=gnome-base/gail-1.6.0
		>=gnome-extra/at-spi-1.4.0
		>=app-accessibility/gnome-speech-0.3.2-r1
		>=app-accessibility/gnome-mag-0.10.10
		>=app-accessibility/gok-0.10.0
		>=app-accessibility/gnopernicus-0.8.0 )"

# gst stuff
#	applets

# unrelated
# scrollkeeper
# pkgconfig
# intltool
# gtk-doc

pkg_postinst () {

	einfo "Note that to change windowmanager to metacity do: "
	einfo " export WINDOW_MANAGER=\"/usr/bin/metacity\""
	einfo "of course this works for all other window managers as well"
	echo
	echo
	einfo "To have nautilus and gnome-vfs monitor file changes, you should"
	einfo "start the FAM daemon. You can do this to by issueing the"
	einfo "'/etc/init.d/famd start' command."
	einfo "'rc-update add fam default' will make FAM start on every boot."
	echo

}

