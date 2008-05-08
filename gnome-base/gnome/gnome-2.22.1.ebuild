# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome/gnome-2.22.1.ebuild,v 1.2 2008/05/08 12:24:24 eva Exp $
EAPI="1"

DESCRIPTION="Meta package for the GNOME desktop"
HOMEPAGE="http://www.gnome.org/"

LICENSE="as-is"
SLOT="2.0"

# when unmasking for an arch
# double check none of the deps are still masked !
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

IUSE="accessibility cdr cups dvdr esd ldap mono"

S=${WORKDIR}

RDEPEND="
	>=dev-libs/glib-2.16.3
	>=x11-libs/gtk+-2.12.9
	>=dev-libs/atk-1.22.0
	>=x11-libs/pango-1.20.1

	>=dev-libs/libxml2-2.6.31
	>=dev-libs/libxslt-1.1.22

	>=media-libs/audiofile-0.2.6-r1
	esd? ( >=media-sound/esound-0.2.38 )
	>=x11-libs/libxklavier-3.3
	>=media-libs/libart_lgpl-2.3.20

	>=dev-libs/libIDL-0.8.10
	>=gnome-base/orbit-2.14.12

	>=x11-libs/libwnck-2.22.1
	>=x11-wm/metacity-2.22.0

	>=gnome-base/gnome-keyring-2.22.1
	>=app-crypt/seahorse-2.22.1

	>=gnome-base/gnome-vfs-2.22.0

	>=gnome-base/gnome-mime-data-2.18.0

	>=gnome-base/gconf-2.22.0
	>=net-libs/libsoup-2.4.1

	>=gnome-base/libbonobo-2.22.0
	>=gnome-base/libbonoboui-2.22.0
	>=gnome-base/libgnome-2.22.0
	>=gnome-base/libgnomeui-2.22.1
	>=gnome-base/libgnomecanvas-2.20.1.1
	>=gnome-base/libglade-2.6.2

	>=gnome-extra/bug-buddy-2.22.0
	>=gnome-base/libgnomekbd-2.22.0
	>=gnome-base/gnome-settings-daemon-2.22.1
	>=gnome-base/control-center-2.22.1

	>=gnome-base/gvfs-0.2.3
	>=gnome-base/eel-2.22.1
	>=gnome-base/nautilus-2.22.2

	>=media-libs/gstreamer-0.10.19
	>=media-libs/gst-plugins-base-0.10.19
	>=media-libs/gst-plugins-good-0.10.6
	>=gnome-extra/gnome-media-2.22.0
	>=media-sound/sound-juicer-2.22.0
	>=dev-libs/totem-pl-parser-2.22.2
	>=media-video/totem-2.22.1

	>=media-gfx/eog-2.22.1

	>=www-client/epiphany-2.22.1.1
	>=app-arch/file-roller-2.22.2
	>=gnome-extra/gcalctool-5.22.1

	>=gnome-extra/gconf-editor-2.22.0
	>=gnome-base/gdm-2.20.5
	>=x11-libs/gtksourceview-1.8.5:1.0
	>=x11-libs/gtksourceview-2.2.1:2.0
	>=app-editors/gedit-2.22.1

	>=app-text/evince-2.22.1.1

	>=gnome-base/gnome-desktop-2.22.1
	>=gnome-base/gnome-session-2.22.1
	>=dev-libs/libgweather-2.22.1.1
	>=gnome-base/gnome-applets-2.22.1
	>=gnome-base/gnome-panel-2.22.1.1
	>=gnome-base/gnome-menus-2.22.1
	>=x11-themes/gnome-icon-theme-2.22.0
	>=x11-themes/gnome-themes-2.22.0
	>=gnome-extra/deskbar-applet-2.22.1

	>=x11-themes/gtk-engines-2.14.1
	>=x11-themes/gnome-backgrounds-2.22.0

	>=x11-libs/vte-0.16.13
	>=x11-terms/gnome-terminal-2.22.1

	>=gnome-extra/gucharmap-2.22.1
	>=gnome-base/libgnomeprint-2.18.4
	>=gnome-base/libgnomeprintui-2.18.2

	>=gnome-extra/gnome-utils-2.20.0.1

	>=dev-python/gnome-python-desktop-2.22.0
	>=gnome-extra/gnome-games-2.22.1.1
	>=gnome-base/librsvg-2.22.2

	>=gnome-extra/gnome-system-monitor-2.22.0
	>=gnome-base/libgtop-2.22.0

	>=x11-libs/startup-notification-0.9

	>=gnome-extra/gnome2-user-docs-2.22.0
	>=gnome-extra/yelp-2.22.1
	>=gnome-extra/zenity-2.22.1

	>=net-analyzer/gnome-netstatus-2.12.1
	>=net-analyzer/gnome-nettool-2.22.0

	cdr? ( >=gnome-extra/nautilus-cd-burner-2.22.1 )
	dvdr? ( >=gnome-extra/nautilus-cd-burner-2.22.1 )

	>=gnome-extra/gtkhtml-3.18.1
	>=mail-client/evolution-2.22.1
	>=gnome-extra/evolution-data-server-2.22.1
	>=gnome-extra/evolution-webcal-2.21.92

	>=net-misc/vino-2.22.1

	>=gnome-extra/fast-user-switch-applet-2.22.0

	>=app-admin/pessulus-2.16.4
	ldap? (
		>=app-admin/sabayon-2.22.0
		>=net-im/ekiga-2.0.12
		)

	>=gnome-extra/gnome-screensaver-2.22.2
	>=x11-misc/alacarte-0.11.5
	!ppc64? ( >=gnome-extra/gnome-power-manager-2.22.1 )
	>=gnome-base/gnome-volume-manager-2.22.1

	>=net-misc/vinagre-0.5.1
	>=gnome-extra/swfdec-gnome-2.22.2

	accessibility? (
		>=gnome-extra/libgail-gnome-1.20.0
		>=gnome-base/gail-1.22.1
		>=gnome-extra/at-spi-1.22.1
		>=app-accessibility/dasher-4.7.3
		>=app-accessibility/gnome-mag-0.15.0
		>=app-accessibility/gnome-speech-0.4.18
		>=app-accessibility/gok-1.3.7
		>=app-accessibility/orca-2.22.1
		>=gnome-extra/mousetweaks-2.22.1 )
	cups? ( >=net-print/gnome-cups-manager-0.31-r2 )

	mono? ( >=app-misc/tomboy-0.10.0 )"
# Broken from assumptions of gnome-vfs headers being included in nautilus headers,
# which isn't the case with nautilus-2.22, bug #216019
#	>=app-admin/gnome-system-tools-2.14.0
#	>=app-admin/system-tools-backends-1.4.2

# Development tools
#   scrollkeeper
#   pkgconfig
#   intltool
#   gtk-doc
#   gnome-doc-utils

pkg_postinst() {

	elog "Note that to change windowmanager to metacity do: "
	elog " export WINDOW_MANAGER=\"/usr/bin/metacity\""
	elog "of course this works for all other window managers as well"
	elog
	elog "The main file alteration monitoring functionality is now"
	elog "provided by >=glib-2.16. Note that on a modern Linux system"
	elog "you do not need the USE=fam flag on it if you have inotify"
	elog "support in your linux kernel ( >=2.6.13 ) enabled."
	elog "USE=fam on glib is however useful for other situations,"
	elog "such as Gentoo/FreeBSD systems. A global USE=fam can also"
	elog "be useful for other packages that do not use the new file"
	elog "monitoring API yet that the new glib provides."
	elog
	elog
	elog "Add yourself to the plugdev group if you want"
	elog "automounting to work."
	elog
}
