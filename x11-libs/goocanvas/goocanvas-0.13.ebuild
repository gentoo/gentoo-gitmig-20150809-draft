# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/goocanvas/goocanvas-0.13.ebuild,v 1.1 2009/01/18 21:14:44 eva Exp $

inherit gnome2 libtool

DESCRIPTION="GooCanvas is a canvas widget for GTK+ using the cairo 2D library for drawing."
HOMEPAGE="http://live.gnome.org/GooCanvas"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE="doc"

RDEPEND=">=x11-libs/gtk+-2.10
	>=dev-libs/glib-2.10
	>=x11-libs/cairo-1.4"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( >=dev-util/gtk-doc-1.8 )"

DOCS="AUTHORS ChangeLog NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF} --disable-rebuilds"
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Fails to build with recent GTK+
	sed -e "s/-D.*_DISABLE_DEPRECATED//g" \
		-i src/Makefile.am src/Makefile.in demo/Makefile.am demo/Makefile.in \
		|| die "sed failed"

	# Needed for FreeBSD - Please do not remove
	elibtoolize
}

