# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/dconf/dconf-0.5.1.ebuild,v 1.1 2010/10/17 19:32:47 pacho Exp $

EAPI=3
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="Simple low-level configuration system"
HOMEPAGE="http://live.gnome.org/dconf"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc +introspection"

RDEPEND=">=dev-libs/glib-2.25.16
	>=dev-libs/libgee-0.5.1
	>=dev-libs/libxml2-2.7.7
	x11-libs/gtk+:2
	introspection? ( >=dev-libs/gobject-introspection-0.9.3 )"
DEPEND="${RDEPEND}
	doc? ( >=dev-util/gtk-doc-1.15 )"

pkg_setup() {
	G2CONF="${G2CONF}
		$(use_enable introspection)"
}
