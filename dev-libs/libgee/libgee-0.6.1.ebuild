# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libgee/libgee-0.6.1.ebuild,v 1.1 2011/01/29 21:11:52 nirbheek Exp $

EAPI="1"

inherit gnome2 multilib

DESCRIPTION="GObject-based interfaces and classes for commonly used data structures."
HOMEPAGE="http://live.gnome.org/Libgee"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="+introspection"

RDEPEND=">=dev-libs/glib-2.12
	introspection? ( >=dev-libs/gobject-introspection-0.9.6 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog* MAINTAINERS NEWS README"

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable introspection)"
}

src_install() {
	gnome2_src_install
	find "${D}" -name "*.la" -delete || die
}
