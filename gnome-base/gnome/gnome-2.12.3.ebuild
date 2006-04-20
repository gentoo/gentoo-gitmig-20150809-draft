# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome/gnome-2.12.3.ebuild,v 1.7 2006/04/20 19:07:01 wolf31o2 Exp $

DESCRIPTION="Meta package for the GNOME desktop"
HOMEPAGE="http://www.gnome.org/"

LICENSE="as-is"
SLOT="2.0"

# when unmasking for an arch
# double check none of the deps are still masked !
KEYWORDS="~alpha amd64 hppa ia64 ppc sparc x86"

IUSE="accessibility cdr dvdr hal"

S=${WORKDIR}

RDEPEND="!gnome-base/gnome-core

	>=dev-libs/glib-2.8.6
	>=x11-libs/gtk+-2.8.11
	>=dev-libs/atk-1.10.3
	>=x11-libs/pango-1.10.3

	>=dev-libs/libxml2-2.6.23
	>=dev-libs/libxslt-1.1.15

	>=media-libs/audiofile-0.2.6-r1
	>=media-sound/esound-0.2.36
	>=x11-libs/libxklavier-2
	>=media-libs/libart_lgpl-2.3.17

	>=dev-libs/libIDL-0.8.6
	>=gnome-base/orbit-2.12.5

	>=x11-libs/libwnck-2.12.3
	>=x11-wm/metacity-2.12.3

	>=gnome-base/gnome-keyring-0.4.6
	>=gnome-extra/gnome-keyring-manager-2.12

	>=gnome-base/gnome-vfs-2.12.2

	>=gnome-base/gnome-mime-data-2.4.2

	>=gnome-base/gconf-2.12.1
	>=net-libs/libsoup-2.2.7

	>=gnome-base/libbonobo-2.10.1
	>=gnome-base/libbonoboui-2.10.1
	>=gnome-base/libgnome-2.12.0.1
	>=gnome-base/libgnomeui-2.12
	>=gnome-base/libgnomecanvas-2.12
	>=gnome-base/libglade-2.5.1

	>=gnome-extra/bug-buddy-2.12.1
	>=gnome-base/control-center-2.12.3

	>=gnome-base/eel-2.12.2
	>=gnome-base/nautilus-2.12.2

	=media-libs/gstreamer-0.8*
	=media-libs/gst-plugins-0.8*
	>=gnome-extra/gnome-media-2.12
	>=media-sound/sound-juicer-2.12.3
	>=media-video/totem-1.2.1

	>=media-gfx/eog-2.12.3

	>=www-client/epiphany-1.8.4.1
	>=app-arch/file-roller-2.12.3
	>=gnome-extra/gcalctool-5.6.31

	>=gnome-extra/gconf-editor-2.12.1
	>=gnome-base/gdm-2.8.0.7
	>=x11-libs/gtksourceview-1.4.2
	>=app-editors/gedit-2.12.1

	>=app-text/evince-0.4.0

	>=gnome-base/gnome-desktop-2.12.3
	>=gnome-base/gnome-session-2.12.0
	>=gnome-base/gnome-applets-2.12.3
	>=gnome-base/gnome-panel-2.12.3
	>=gnome-base/gnome-menus-2.12.0
	>=x11-themes/gnome-icon-theme-2.12.1
	>=x11-themes/gnome-themes-2.12.3

	>=x11-themes/gtk-engines-2.6.7
	>=x11-themes/gnome-backgrounds-2.12.3.1

	>=x11-libs/vte-0.11.17
	>=x11-terms/gnome-terminal-2.12.0

	>=gnome-extra/gucharmap-1.4.4
	>=gnome-base/libgnomeprint-2.12.1
	>=gnome-base/libgnomeprintui-2.12.1

	>=gnome-extra/gnome-utils-2.12.2

	>=gnome-extra/gnome-games-2.12.3
	>=gnome-base/librsvg-2.12.7

	>=gnome-extra/gnome-system-monitor-2.12.2
	>=gnome-base/libgtop-2.12.2

	>=x11-libs/startup-notification-0.8

	>=gnome-extra/gnome2-user-docs-2.8.1
	>=gnome-extra/yelp-2.12.2
	>=gnome-extra/zenity-2.12.1

	>=net-analyzer/gnome-netstatus-2.12.0
	>=net-analyzer/gnome-nettool-1.4.1

	cdr? ( >=gnome-extra/nautilus-cd-burner-2.12.3 )
	dvdr? ( >=gnome-extra/nautilus-cd-burner-2.12.3 )

	hal? ( >=gnome-base/gnome-volume-manager-1.5.4 )

	>=gnome-extra/gtkhtml-3.8.2
	>=mail-client/evolution-2.4.2.1
	>=gnome-extra/evolution-data-server-1.4.2.1
	>=gnome-extra/evolution-webcal-2.4.1

	>=net-misc/vino-2.12.0

	>=app-admin/gnome-system-tools-1.4.1
	>=app-admin/system-tools-backends-1.4.2

	accessibility? (
		>=gnome-extra/libgail-gnome-1.1.3
		>=gnome-base/gail-1.8.8
		>=gnome-extra/at-spi-1.6.6
		>=app-accessibility/dasher-3.2.18
		>=app-accessibility/gnome-mag-0.12.3
		>=app-accessibility/gnome-speech-0.3.9
		>=app-accessibility/gok-1.0.5
		>=app-accessibility/gnopernicus-0.11.8 )"

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
