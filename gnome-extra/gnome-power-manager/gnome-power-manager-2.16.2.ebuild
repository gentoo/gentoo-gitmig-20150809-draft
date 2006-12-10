# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-power-manager/gnome-power-manager-2.16.2.ebuild,v 1.5 2006/12/10 18:40:16 ticho Exp $

GNOME_TARBALL_SUFFIX="gz"

inherit gnome2 eutils

DESCRIPTION="Gnome Power Manager"
HOMEPAGE="http://www.gnome.org/projects/gnome-power-manager/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc x86"
IUSE="doc libnotify"

RDEPEND=">=dev-libs/glib-2.6.0
		 >=x11-libs/gtk+-2.10.0
		 >=gnome-base/libgnome-2.14.0
		 >=gnome-base/libgnomeui-2.10.0
		 >=sys-apps/hal-0.5.7-r1
		 >=gnome-base/libglade-2.5.0
		 >=x11-libs/libwnck-2.10.0
		 >=x11-libs/cairo-1.0.0
		 >=gnome-base/gconf-2
		 x11-libs/libX11
		 x11-libs/libXext
		 || (
				>=dev-libs/dbus-glib-0.71
				( <sys-apps/dbus-0.90 >=sys-apps/dbus-0.61 )
			)
		 libnotify? (
						>=x11-libs/libnotify-0.4.3
						>=x11-misc/notification-daemon-0.2.1
					)"
DEPEND="${RDEPEND}
		sys-devel/gettext
		dev-util/pkgconfig
		>=dev-util/intltool-0.35
		doc? (
				app-text/xmlto
				app-text/gnome-doc-utils
				app-text/docbook-sgml-utils
			 )"

DOCS="AUTHORS ChangeLog NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable doc docbook-docs) $(use_enable libnotify) \
			--enable-actions-menu --with-dpms-ext"
}

pkg_postinst() {
	gnome2_pkg_postinst

	einfo "You will need the masked pam_console to be able to"
	einfo "suspend/hibernate, or you will need to:"
	einfo "touch /var/run/console/<USERNAME>"
	einfo "after each boot"
}
