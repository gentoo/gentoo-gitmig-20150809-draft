# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gtkhtml/gtkhtml-3.30.3.ebuild,v 1.2 2010/09/26 15:14:01 nirbheek Exp $

EAPI="2"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="Lightweight HTML Rendering/Printing/Editing Engine"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 LGPL-2"
SLOT="3.14"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"
IUSE=""

# We keep bonobo until we can make sure no apps in tree uses
# the old composer code.
RDEPEND=">=x11-libs/gtk+-2.20
	>=x11-themes/gnome-icon-theme-2.22.0
	>=gnome-base/orbit-2
	>=app-text/enchant-1.1.7
	gnome-base/gconf:2
	>=app-text/iso-codes-0.49
	>=net-libs/libsoup-2.26.0:2.4"
DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/intltool-0.40.0
	>=dev-util/pkgconfig-0.9"

DOCS="AUTHORS BUGS ChangeLog NEWS README TODO"

pkg_setup() {
	ELTCONF="--reverse-deps"
	G2CONF="${G2CONF}
		--disable-static"
}

src_prepare() {
	gnome2_src_prepare

	# XXX: This is fixed with --disable-deprecations in >=3.31.90
	sed -e 's/CFLAGS="$CFLAGS $WARNING_FLAGS/CFLAGS="$CFLAGS/' \
		-i configure.ac configure || die "Warning flags sed failed"
}
