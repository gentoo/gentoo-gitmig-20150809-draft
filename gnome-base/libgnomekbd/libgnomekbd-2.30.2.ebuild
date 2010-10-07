# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgnomekbd/libgnomekbd-2.30.2.ebuild,v 1.7 2010/10/07 21:49:04 ssuominen Exp $

EAPI="2"
GCONF_DEBUG="no"

inherit gnome2 multilib

DESCRIPTION="Gnome keyboard configuration library"
HOMEPAGE="http://www.gnome.org"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ia64 ppc ppc64 ~sh ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="test"

# gtk+-2.20 needed for tests
RDEPEND=">=dev-libs/glib-2.18
	>=gnome-base/gconf-2.14
	>=x11-libs/gtk+-2.20
	>=x11-libs/libxklavier-5.0"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35
	>=dev-util/pkgconfig-0.19"

DOCS="AUTHORS ChangeLog NEWS README"

pkg_setup() {
	# Only user interaction required graphical tests at the time of 2.22.0 - not useful for us
	G2CONF="${G2CONF} $(use_enable test tests) --disable-static"
}

src_compile() {
	# FreeBSD doesn't like -j, upstream? bug #????
	use x86-fbsd && MAKEOPTS="${MAKEOPTS} -j1"
	gnome2_src_compile
}
