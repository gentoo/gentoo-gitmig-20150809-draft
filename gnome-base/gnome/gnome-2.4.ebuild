# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome/gnome-2.4.ebuild,v 1.14 2004/03/17 22:47:52 leonardop Exp $

S=${WORKDIR}
DESCRIPTION="Meta package for the GNOME desktop."
HOMEPAGE="http://www.gnome.org/"
LICENSE="as-is"
SLOT="2.0"

IUSE="cdr doc"

# when unmasking for an arch
# double check none of the deps are still masked !
# We're not kidding!
KEYWORDS="x86 amd64 ppc alpha sparc hppa"

#  Note to developers:
#  This is a wrapper for the complete Gnome2 desktop,
#  This means all components that a user expects in Gnome2 are present
#  please do not reduce this list further unless
#  dependencies pull in what you remove.
#  With "emerge gnome" a user expects the full "standard" distribution of Gnome and should be provided with that, consider only installing the parts needed for smaller installations.

RDEPEND="!gnome-base/gnome-core

	>=gnome-base/gconf-2.4.0.1
	>=gnome-base/ORBit2-2.8.1
	>=dev-libs/atk-1.4
	>=media-libs/audiofile-0.2.3
	>=media-sound/esound-0.2.32
	>=gnome-base/gail-1.4
	>=dev-libs/glib-2.2.3
	>=gnome-base/gnome-mime-data-2.4
	>=gnome-base/gnome-vfs-2.4
	>=x11-libs/gtk+-2.2.4-r1
	>=media-libs/libart_lgpl-2.3.16

	>=gnome-base/libbonobo-2.4
	>=gnome-base/libbonoboui-2.4
	>=gnome-base/libglade-2.0.1
	>=gnome-base/libgnome-2.4
	>=gnome-base/libgnomecanvas-2.4
	>=gnome-base/libgnomeui-2.4.0.1

	>=dev-libs/libIDL-0.8.2
	>=dev-libs/libxml2-2.5.11
	>=dev-libs/libxslt-1.0.33
	>=x11-libs/pango-1.2.5

	>=gnome-extra/acme-2.4
	>=gnome-extra/bug-buddy-2.4

	>=gnome-base/control-center-2.4

	>=gnome-base/eel-2.4
	>=gnome-base/nautilus-2.4
	>=gnome-extra/nautilus-media-0.3.3.1

	>=media-gfx/eog-2.4
	!hppa? ( >=net-www/epiphany-1 )
	>=app-arch/file-roller-2.4.0.1
	>=gnome-extra/gcalctool-4.3.3
	>=gnome-extra/gconf-editor-2.4
	>=gnome-base/gdm-2.2
	>=app-editors/gedit-2.4
	>=app-text/ggv-2.4.0.1
	>=app-text/gpdf-0.110
	>=gnome-base/gnome-applets-2.4
	>=gnome-base/gnome-desktop-2.4
	>=gnome-extra/gnome-games-2.4

	>=x11-themes/gtk-engines-2.2
	>=x11-themes/gnome-icon-theme-1.0.9

	>=gnome-extra/gnome-media-2.4
	>=gnome-base/gnome-panel-2.4
	>=gnome-base/gnome-session-2.4
	>=gnome-extra/gnome-system-monitor-2.4
	>=x11-terms/gnome-terminal-2.4.0.1
	>=x11-themes/gnome-themes-2.4
	>=gnome-extra/gnome2-user-docs-2.4
	>=gnome-extra/gnome-utils-2.4
	>=media-libs/gstreamer-0.6.3
	>=media-libs/gst-plugins-0.6.3
	>=x11-libs/gtksourceview-0.6
	>=gnome-extra/gucharmap-1
	>=gnome-base/libgnomeprint-2.3.1
	>=gnome-base/libgnomeprintui-2.3.1
	=gnome-extra/libgtkhtml-2.4*
	>=gnome-base/libgtop-2.0.5
	>=gnome-base/librsvg-2.4
	>=x11-libs/libwnck-2.4.0.1
	>=x11-wm/metacity-2.6.1
	>=gnome-extra/zenity-1.6

	>=x11-libs/startup-notification-0.5

	>=gnome-extra/yelp-2.4
	>=x11-libs/vte-0.11.10

	>=app-text/scrollkeeper-0.3.12
	>=dev-util/pkgconfig-0.15
	>=dev-util/intltool-0.27.2
	cdr? ( >=gnome-extra/nautilus-cd-burner-0.5.3 )
	doc? ( >=dev-util/gtk-doc-0.15 )"

# accesibility still missing

pkg_postinst () {
	einfo "note that to change windowmanager to metacity do: "
	einfo " export WINDOW_MANAGER=\"/usr/bin/metacity\""
	einfo "of course this works for all other window managers as well"
	echo ""
	echo ""
	einfo "if you want better behaviour from Nautilus, do "
	einfo "'rc-update add fam default'  to enable the file alteration monitor"
	echo ""
}
