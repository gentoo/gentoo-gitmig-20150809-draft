# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/clutter-gtk/clutter-gtk-0.91.8.ebuild,v 1.3 2011/02/19 23:33:07 nirbheek Exp $

EAPI="2"

# inherit clutter after gnome2 so that defaults aren't overriden
inherit gnome2 clutter

DESCRIPTION="Clutter-GTK - GTK+3 Integration library for Clutter"

SLOT="1.0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="doc debug examples +introspection"

# XXX: Needs gtk with X support (!directfb)
RDEPEND="
	>=x11-libs/gtk+-2.91.7:3[introspection?]
	>=media-libs/clutter-1.2:1.0[introspection?]
	introspection? ( >=dev-libs/gobject-introspection-0.9.12 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=sys-devel/gettext-0.18
	doc? ( >=dev-util/gtk-doc-1.14 )"
EXAMPLES="examples/{*.c,*.ui,redhand.png}"

src_prepare() {
	G2CONF="${G2CONF}
		--with-flavour=x11
		--enable-maintainer-flags=no
		$(use_enable introspection)"

	sed -e "s/\(DOC_MODULE.*=.*${PN}\).*/\1-1.0/" \
		-i doc/reference/Makefile.{am,in} || die "sed failed"
}
