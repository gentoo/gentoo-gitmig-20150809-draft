# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome/gnome-2.16.1.ebuild,v 1.5 2006/12/17 01:22:32 dertobi123 Exp $

DESCRIPTION="Meta package for the GNOME desktop"
HOMEPAGE="http://www.gnome.org/"

LICENSE="as-is"
SLOT="2.0"

# when unmasking for an arch
# double check none of the deps are still masked !
KEYWORDS="~alpha amd64 ppc ~sparc x86"

IUSE="accessibility cdr cups dvdr hal ldap mono"

S=${WORKDIR}

RDEPEND="!gnome-base/gnome-core

	>=dev-libs/glib-2.12.4
	>=x11-libs/gtk+-2.10.6
	>=dev-libs/atk-1.12.3
	>=x11-libs/pango-1.14.5

	>=dev-libs/libxml2-2.6.26
	>=dev-libs/libxslt-1.1.17

	>=media-libs/audiofile-0.2.6-r1
	>=media-sound/esound-0.2.36
	>=x11-libs/libxklavier-3.0
	>=media-libs/libart_lgpl-2.3.17

	>=dev-libs/libIDL-0.8.7
	>=gnome-base/orbit-2.14.2

	>=x11-libs/libwnck-2.16.1
	>=x11-wm/metacity-2.16.3

	>=gnome-base/gnome-keyring-0.6.0
	>=gnome-extra/gnome-keyring-manager-2.16.0

	>=gnome-base/gnome-vfs-2.16.1

	>=gnome-base/gnome-mime-data-2.4.2

	>=gnome-base/gconf-2.14.0
	>=net-libs/libsoup-2.2.96

	>=gnome-base/libbonobo-2.16.0
	>=gnome-base/libbonoboui-2.16.0
	>=gnome-base/libgnome-2.16.0
	>=gnome-base/libgnomeui-2.16.0
	>=gnome-base/libgnomecanvas-2.14.0
	>=gnome-base/libglade-2.6.0

	>=gnome-extra/bug-buddy-2.16.0
	>=gnome-base/control-center-2.16.1

	>=gnome-base/eel-2.16.0
	>=gnome-base/nautilus-2.16.1

	>=media-libs/gstreamer-0.10.8
	>=media-libs/gst-plugins-base-0.10.7
	>=media-libs/gst-plugins-good-0.10.3
	>=gnome-extra/gnome-media-2.16.1
	>=media-sound/sound-juicer-2.16.1
	>=media-video/totem-2.16.2

	>=media-gfx/eog-2.16.1

	>=www-client/epiphany-2.16.1
	>=app-arch/file-roller-2.16.0
	>=gnome-extra/gcalctool-5.8.24

	>=gnome-extra/gconf-editor-2.16.0
	>=gnome-base/gdm-2.16.1
	>=x11-libs/gtksourceview-1.8.1
	>=app-editors/gedit-2.16.1

	>=app-text/evince-0.6.0

	>=gnome-base/gnome-desktop-2.16.1
	>=gnome-base/gnome-session-2.16.1
	>=gnome-base/gnome-applets-2.16.1
	>=gnome-base/gnome-panel-2.16.1
	>=gnome-base/gnome-menus-2.16.1
	>=x11-themes/gnome-icon-theme-2.16.0.1
	>=x11-themes/gnome-themes-2.16.1
	>=gnome-extra/deskbar-applet-2.16.0

	>=x11-themes/gtk-engines-2.8.1
	>=x11-themes/gnome-backgrounds-2.16.1

	>=x11-libs/vte-0.14.1
	>=x11-terms/gnome-terminal-2.16.1

	>=gnome-extra/gucharmap-1.8.0
	>=gnome-base/libgnomeprint-2.12.1
	>=gnome-base/libgnomeprintui-2.12.1

	>=gnome-extra/gnome-utils-2.16.1

	>=gnome-extra/gnome-games-2.16.1
	>=gnome-base/librsvg-2.16.0

	>=gnome-extra/gnome-system-monitor-2.16.1
	>=gnome-base/libgtop-2.14.4

	>=x11-libs/startup-notification-0.8

	>=gnome-extra/gnome2-user-docs-2.16.1
	>=gnome-extra/yelp-2.16.1
	>=gnome-extra/zenity-2.16.1

	>=net-analyzer/gnome-netstatus-2.12.0
	>=net-analyzer/gnome-nettool-2.16.0

	cdr? ( >=gnome-extra/nautilus-cd-burner-2.16.1 )
	dvdr? ( >=gnome-extra/nautilus-cd-burner-2.16.1 )

	hal? ( >=gnome-base/gnome-volume-manager-2.15.0 )

	>=gnome-extra/gtkhtml-3.12.1
	>=mail-client/evolution-2.8.1
	>=gnome-extra/evolution-data-server-1.8.1
	>=gnome-extra/evolution-webcal-2.8.0

	>=net-misc/vino-2.13.5

	>=app-admin/gnome-system-tools-2.14.0
	>=app-admin/system-tools-backends-1.4.2
	>=gnome-extra/fast-user-switch-applet-2.16.0

	>=app-admin/pessulus-2.16.1
	ldap? (
		>=app-admin/sabayon-2.12.4
		>=net-im/ekiga-2.0.3
		)

	>=gnome-extra/gnome-screensaver-2.16.1
	>=x11-misc/alacarte-0.10.0
	>=gnome-extra/gnome-power-manager-2.16.1

	accessibility? (
		>=gnome-extra/libgail-gnome-1.1.3
		>=gnome-base/gail-1.9.3
		>=gnome-extra/at-spi-1.7.12
		>=app-accessibility/dasher-4.2.0
		>=app-accessibility/gnome-mag-0.13.1
		>=app-accessibility/gnome-speech-0.4.5
		>=app-accessibility/gok-1.2.0
		>=app-accessibility/gnopernicus-1.0.4 )
	cups? ( >=net-print/gnome-cups-manager-0.31-r1 )"

#	mono? ( >=app-misc/tomboy-0.4.1 )

# Development tools
#   scrollkeeper
#   pkgconfig
#   intltool
#   gtk-doc
#   gnome-doc-utils


pkg_postinst() {

	einfo "Note that to change windowmanager to metacity do: "
	einfo " export WINDOW_MANAGER=\"/usr/bin/metacity\""
	einfo "of course this works for all other window managers as well"
	einfo
	einfo "To take full advantage of GNOME's functionality, please emerge"
	einfo "gamin, a File Alteration Monitor."
	einfo "Make sure you have inotify enabled in your kernel ( >=2.6.13 )"
	einfo
	einfo "Make sure you rc-update del famd and emerge unmerge fam if you"
	einfo "are switching from fam to gamin."
	einfo
	einfo "If you have problems, you may want to try using fam instead."
	einfo
	einfo
	einfo "Add yourself to the plugdev group if you want"
	einfo "automounting to work."
	einfo
}
