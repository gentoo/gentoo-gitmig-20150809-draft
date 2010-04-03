# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gtranslator/gtranslator-1.9.9.ebuild,v 1.1 2010/04/03 11:49:13 eva Exp $

EAPI="3"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="An enhanced gettext po file editor for GNOME"
HOMEPAGE="http://gtranslator.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="http gnome spell"

RDEPEND="
	>=dev-libs/glib-2.16:2
	>=dev-libs/gdl-2.26
	>=dev-libs/libunique-1
	>=dev-libs/libxml2-2.4.12
	>=gnome-base/gconf-2.18
	>=sys-libs/db-4.3
	>=x11-libs/gtk+-2.18:2
	>=x11-libs/gtksourceview-2.4:2.0

	gnome? (
		gnome-extra/gnome-utils
		>=gnome-extra/gucharmap-2 )
	http? ( >=net-libs/libsoup-2.4:2.4 )
	spell? ( >=app-text/gtkspell-2.0.2 )"
DEPEND="${RDEPEND}
	>=app-text/scrollkeeper-0.1.4
	>=dev-util/intltool-0.40
	>=sys-devel/gettext-0.17
	dev-util/pkgconfig
	app-text/gnome-doc-utils
	app-text/docbook-xml-dtd:4.1.2
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog HACKING INSTALL NEWS README THANKS TODO"

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-static
		$(use_with gnome dictionary)
		$(use_with spell gtkspell)"

	if use http; then
		G2CONF="${G2CONF} enable_opentran=yes"
	else
		G2CONF="${G2CONF} enable_opentran=no"
	fi
}

src_install() {
	gnome2_src_install

	# Clean up unused libtool generated content
	find "${D}" -name "*.la" -delete || die "failed to remove *.la"
}
