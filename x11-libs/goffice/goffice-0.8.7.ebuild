# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/goffice/goffice-0.8.7.ebuild,v 1.1 2010/07/03 14:39:59 pacho Exp $

EAPI="2"
GCONF_DEBUG="no"

inherit eutils gnome2 flag-o-matic

DESCRIPTION="A library of document-centric objects and utilities"
HOMEPAGE="http://freshmeat.net/projects/goffice/"

LICENSE="GPL-2"
SLOT="0.8"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~x64-solaris"
IUSE="doc gnome"

# Build fails with -gtk
# FIXME: add lasem to tree
RDEPEND=">=dev-libs/glib-2.16
	>=gnome-extra/libgsf-1.14.9[gnome?]
	>=dev-libs/libxml2-2.4.12
	>=x11-libs/pango-1.8.1
	>=x11-libs/cairo-1.2[svg]
	x11-libs/libXext
	x11-libs/libXrender
	>=x11-libs/gtk+-2.16
	gnome? ( >=gnome-base/gconf-2 )
"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.18
	>=dev-util/intltool-0.35
	doc? ( >=dev-util/gtk-doc-1.11 )"

DOCS="AUTHORS BUGS ChangeLog MAINTAINERS NEWS README"

pkg_setup() {
	G2CONF="${G2CONF}
		--without-lasem
		--with-gtk
		$(use_with gnome gconf)"
	filter-flags -ffast-math
}

src_prepare() {
	gnome2_src_prepare

	# Fix intltoolize broken file, see upstream #577133
	sed "s:'\^\$\$lang\$\$':\^\$\$lang\$\$:g" -i po/Makefile.in.in \
		|| die "sed failed"
}

src_install() {
	gnome2_src_install
	find "${D}" -name "*.la" -delete || die
}
