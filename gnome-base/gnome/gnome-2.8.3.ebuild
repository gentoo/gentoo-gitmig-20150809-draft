# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome/gnome-2.8.3.ebuild,v 1.2 2005/03/23 15:11:56 seemant Exp $

DESCRIPTION="Meta package for the GNOME desktop"
HOMEPAGE="http://www.gnome.org/"

LICENSE="as-is"
SLOT="2.0"
# when unmasking for an arch
# double check none of the deps are still masked !
KEYWORDS="~x86 ~ppc ~sparc ~amd64 ~mips ~hppa ~ia64 ~alpha"
IUSE="accessibility cdr dvdr hal"

S=${WORKDIR}

RDEPEND="!gnome-base/gnome-core

	>=dev-libs/glib-2.4.8
	>=dev-libs/atk-1.8
	>=x11-libs/gtk+-2.4.14
	>=x11-libs/pango-1.6

	hppa? ( >=dev-libs/libxml2-2.6.9 )
	!hppa? ( >=dev-libs/libxml2-2.6.17 )
	>=dev-libs/libxslt-1.1.12

	>=x11-libs/libxklavier-1.04-r1
	>=media-libs/audiofile-0.2.6-r1
	>=media-sound/esound-0.2.34
	>=gnome-base/gnome-mime-data-2.4.2
	>=media-libs/libart_lgpl-2.3.17

	>=dev-libs/libIDL-0.8.5
	>=gnome-base/orbit-2.12.1

	>=gnome-base/gconf-2.8.1-r1
	>=gnome-base/gnome-keyring-0.4.1
	>=gnome-base/gnome-vfs-2.8.4

	>=gnome-base/libbonobo-2.8.1
	>=gnome-base/libbonoboui-2.8.1
	>=gnome-base/libgnome-2.8.1
	>=gnome-base/libgnomeui-2.8.1
	>=gnome-base/libgnomecanvas-2.8
	>=gnome-base/libglade-2.4.2

	>=gnome-extra/bug-buddy-2.8
	>=gnome-base/control-center-2.8.2

	>=gnome-base/eel-2.8.2
	>=gnome-base/nautilus-2.8.2-r1

	>=media-libs/gstreamer-0.8.9
	>=media-libs/gst-plugins-0.8.7
	>=gnome-extra/gnome-media-2.8

	>=media-gfx/eog-2.8.2
	!hppa? ( !mips? ( >=www-client/epiphany-1.4.8 ) )
	>=app-arch/file-roller-2.8.4
	>=gnome-extra/gcalctool-4.4.22
	>=gnome-extra/gconf-editor-2.8.2
	>=gnome-base/gdm-2.6.0.7
	>=app-editors/gedit-2.8.3

	>=app-text/ggv-2.8.3
	>=app-text/gpdf-2.8.3

	>=gnome-base/gnome-session-2.8.1
	>=gnome-base/gnome-desktop-2.8.3
	>=gnome-base/gnome-applets-2.8.2
	>=gnome-base/gnome-panel-2.8.3

	>=x11-themes/gnome-icon-theme-2.8
	>=x11-themes/gnome-themes-2.8.2

	>=x11-terms/gnome-terminal-2.8.2
	>=gnome-extra/gnome2-user-docs-2.8.1

	>=x11-libs/gtksourceview-1.1.1
	>=gnome-extra/gucharmap-1.4.2
	>=gnome-base/libgnomeprint-2.8.2
	>=gnome-base/libgnomeprintui-2.8.2

	>=gnome-extra/gnome-utils-2.8.1
	>=gnome-extra/gnome-games-2.8.3

	>=gnome-base/libgtop-2.8.3
	>=gnome-extra/gnome-system-monitor-2.8.3

	>=gnome-base/librsvg-2.8.1-r1
	>=x11-libs/libwnck-2.8.1-r1
	>=x11-wm/metacity-2.8.13

	>=x11-libs/startup-notification-0.8

	>=gnome-extra/yelp-2.6.5
	>=x11-libs/vte-0.11.11-r2
	>=gnome-extra/zenity-2.8.2
	>=net-analyzer/gnome-netstatus-2.8

	cdr? ( >=gnome-extra/nautilus-cd-burner-2.8.7 )
	dvdr? ( >=gnome-extra/nautilus-cd-burner-2.8.7 )

	hal? ( >=gnome-base/gnome-volume-manager-1.0.3 )

	>=gnome-extra/evolution-data-server-1.0.4
	>=mail-client/evolution-2.0.4
	>=gnome-extra/evolution-webcal-2.0.1
	>=gnome-extra/gal-2.2.5
	>=gnome-extra/libgtkhtml-3.2.5

	>=net-misc/vino-2.8.1

	>=app-admin/gnome-system-tools-1.0.2

	accessibility? (
		>=gnome-extra/libgail-gnome-1.1
		>=gnome-base/gail-1.8.2
		>=gnome-extra/at-spi-1.6.2
		>=app-accessibility/gnome-mag-0.11.14
		>=app-accessibility/gok-0.11.17
		>=app-accessibility/gnopernicus-0.9.19 )"

# freetts not stable yet
#		>=app-accessibility/gnome-speech-0.3.6

# unrelated
# scrollkeeper
# pkgconfig
# intltool
# gtk-doc

pkg_postinst() {

	einfo "Note that to change windowmanager to metacity do: "
	einfo " export WINDOW_MANAGER=\"/usr/bin/metacity\""
	einfo "of course this works for all other window managers as well"
	echo
	einfo "To take full advantage of GNOME's functionality, please start"
	einfo "the File Alteration Monitoring service (famd) before using"
	einfo "GNOME, unless you have a specific reason for not doing so."
	echo
	einfo "To start famd now use:"
	einfo "'/etc/init.d/famd start'"
	echo
	einfo "And please ensure you add it to the default runlevel using:"
	einfo "'rc-update add famd default'"
	echo

}
