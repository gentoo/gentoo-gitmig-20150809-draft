# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome/gnome-2.8.0-r1.ebuild,v 1.7 2004/12/01 03:23:21 joem Exp $

S=${WORKDIR}
DESCRIPTION="Meta package for the GNOME desktop"
HOMEPAGE="http://www.gnome.org/"
LICENSE="as-is"
SLOT="2.0"

IUSE="accessibility cdr dvdr hal"
# when unmasking for an arch
# double check none of the deps are still masked !
KEYWORDS="x86 ppc sparc ~amd64 ~mips ~hppa ~ia64 ~alpha"

RDEPEND="!gnome-base/gnome-core

	>=dev-libs/glib-2.4.6
	>=dev-libs/atk-1.8
	>=x11-libs/gtk+-2.4.9
	>=x11-libs/pango-1.6

	hppa? ( >=dev-libs/libxml2-2.6.9 )
	!hppa? ( >=dev-libs/libxml2-2.6.12 )
	>=dev-libs/libxslt-1.1.9

	>=x11-libs/libxklavier-1.03
	>=media-libs/audiofile-0.2.6
	>=media-sound/esound-0.2.34
	>=gnome-base/gnome-mime-data-2.4.1
	>=media-libs/libart_lgpl-2.3.16

	>=dev-libs/libIDL-0.8.4
	>=gnome-base/orbit-2.12

	>=gnome-base/gconf-2.8.0.1
	>=gnome-base/gnome-keyring-0.4
	>=gnome-base/gnome-vfs-2.8.1

	>=gnome-base/libbonobo-2.8
	>=gnome-base/libbonoboui-2.8
	>=gnome-base/libgnome-2.8
	>=gnome-base/libgnomeui-2.8
	>=gnome-base/libgnomecanvas-2.8
	>=gnome-base/libglade-2.4

	>=gnome-extra/bug-buddy-2.8
	>=gnome-base/control-center-2.8

	>=gnome-base/eel-2.8
	>=gnome-base/nautilus-2.8

	>=media-libs/gstreamer-0.8.5
	>=media-libs/gst-plugins-0.8.3
	>=gnome-extra/gnome-media-2.8

	>=media-gfx/eog-2.8
	!hppa? ( !mips? ( >=net-www/epiphany-1.4 ) )
	>=app-arch/file-roller-2.8
	>=gnome-extra/gcalctool-4.4.19
	>=gnome-extra/gconf-editor-2.8
	>=gnome-base/gdm-2.6.0.4
	>=app-editors/gedit-2.8

	>=app-text/ggv-2.8
	>=app-text/gpdf-2.8.0-r2

	>=gnome-base/gnome-session-2.8
	>=gnome-base/gnome-desktop-2.8
	>=gnome-base/gnome-applets-2.8
	>=gnome-base/gnome-panel-2.8.0.1

	>=x11-themes/gnome-icon-theme-2.8
	>=x11-themes/gnome-themes-2.8

	>=x11-terms/gnome-terminal-2.7.3
	>=gnome-extra/gnome2-user-docs-2.8.0.1

	>=x11-libs/gtksourceview-1
	>=gnome-extra/gucharmap-1.4.1
	>=gnome-base/libgnomeprint-2.8
	>=gnome-base/libgnomeprintui-2.8

	>=gnome-extra/gnome-utils-2.8
	>=gnome-extra/gnome-games-2.6

	>=gnome-base/libgtop-2.8
	>=gnome-extra/gnome-system-monitor-2.7

	>=gnome-base/librsvg-2.8.1
	>=x11-libs/libwnck-2.8.0.1
	>=x11-wm/metacity-2.8.5

	>=x11-libs/startup-notification-0.7

	>=gnome-extra/yelp-2.6.4
	>=x11-libs/vte-0.11.11-r1
	>=gnome-extra/zenity-2.8
	>=net-analyzer/gnome-netstatus-2.8

	cdr? ( >=gnome-extra/nautilus-cd-burner-2.8.2 )
	dvdr? ( >=gnome-extra/nautilus-cd-burner-2.8.2 )

	hal? ( >=gnome-base/gnome-volume-manager-1.0.2-r1 )

	>=gnome-extra/evolution-data-server-1
	>=mail-client/evolution-2
	>=gnome-extra/evolution-webcal-2
	>=gnome-extra/gal-2.2.1
	>=gnome-extra/libgtkhtml-3.2.1

	>=net-misc/vino-2.8.0.1

	>=app-admin/gnome-system-tools-1

	accessibility? (
		>=gnome-extra/libgail-gnome-1.1
		>=gnome-base/gail-1.8
		>=gnome-extra/at-spi-1.6
		>=app-accessibility/gnome-mag-0.11.5
		>=app-accessibility/gok-0.11.8
		>=app-accessibility/gnopernicus-0.9.12 )"

# freetts not stable yet
#		>=app-accessibility/gnome-speech-0.3.5






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
	einfo "To have nautilus and gnome-vfs monitor file changes, you should"
	einfo "start the FAM daemon. You can do this to by issueing the"
	einfo "'/etc/init.d/famd start' command."
	einfo "'rc-update add famd default' will make FAM start on every boot."
	echo

}
