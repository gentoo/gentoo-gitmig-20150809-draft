# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/vala/vala-0.5.2.ebuild,v 1.1 2008/12/05 10:22:25 remi Exp $

EAPI="1"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="Vala - Compiler for the GObject type system"
HOMEPAGE="http://live.gnome.org/Vala"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc gtk +vapigen"

RDEPEND=">=dev-libs/glib-2.12.0
	gtk? ( >=x11-libs/gtk+-2.10.0 )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	doc? ( dev-libs/libxslt )"

DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README"

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable vapigen) $(use_enable gtk gen-project)"
}
