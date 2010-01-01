# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/vala/vala-0.6.1.ebuild,v 1.4 2010/01/01 12:47:18 armin76 Exp $

EAPI="1"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="Vala - Compiler for the GObject type system"
HOMEPAGE="http://live.gnome.org/Vala"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~sparc ~x86"
IUSE="+vapigen"

RDEPEND=">=dev-libs/glib-2.12.0"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	dev-libs/libxslt"

RESTRICT="test"

DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README"

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable vapigen)"
}
