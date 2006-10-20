# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/fast-user-switch-applet/fast-user-switch-applet-2.14.2.ebuild,v 1.10 2006/10/20 21:59:01 agriffis Exp $

inherit eutils gnome2

DESCRIPTION="Fast User Switching Applet for Gnome Desktop"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 FDL-1.1 LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND="dev-libs/glib
	x11-libs/pango
	>=x11-libs/gtk+-2.6
	gnome-base/libbonoboui
	gnome-base/libgnome
	gnome-base/orbit
	>=gnome-base/libglade-2.0
	gnome-base/gconf
	gnome-base/libbonobo
	gnome-base/libgnomeui
	gnome-base/gnome-vfs
	gnome-base/gnome-keyring
	gnome-base/libgnomecanvas
	>=gnome-base/gnome-panel-2.0
	|| ( (	x11-libs/libXmu
		x11-libs/libXau
		x11-libs/libSM )
	virtual/x11 )"

DEPEND="${RDEPEND}
	dev-libs/libxslt
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.29
	>=app-text/scrollkeeper-0.1.4
	>=app-text/gnome-doc-utils-0.3.2
	~app-text/docbook-xml-dtd-4.3"

DOCS="AUTHORS ChangeLog NEWS README"

pkg_setup() {
	if has_version '<gnome-base/gdm-2.13.0.8' ; then
		G2CONF="${G2CONF} --with-gdm-config=/etc/X11/gdm/gdm.conf"
	else
		G2CONF="${G2CONF} --with-gdm-config=/usr/share/gdm/defaults.conf"
	fi
}
