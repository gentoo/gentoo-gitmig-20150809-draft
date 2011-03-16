# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgnomekbd/libgnomekbd-2.32.0.ebuild,v 1.6 2011/03/16 10:48:40 nirbheek Exp $

EAPI="3"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="Gnome keyboard configuration library"
HOMEPAGE="http://www.gnome.org"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ~ppc ~ppc64 sh sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="test"

# gtk+-2.20 needed for tests
RDEPEND=">=dev-libs/glib-2.18:2
	>=gnome-base/gconf-2.14:2
	>=x11-libs/gtk+-2.20:2
	>=x11-libs/libxklavier-5.0"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35
	>=dev-util/pkgconfig-0.19"

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable test tests) --disable-static"
	DOCS="AUTHORS ChangeLog NEWS README"
}

#src_compile() {
	# FreeBSD doesn't like -j, upstream? bug #176517
	# FIXME: Please re-test and notify us if still valid,
	# disabling for now
	# use x86-fbsd && MAKEOPTS="${MAKEOPTS} -j1"
#	gnome2_src_compile
#}
