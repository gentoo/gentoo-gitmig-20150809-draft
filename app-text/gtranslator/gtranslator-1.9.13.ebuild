# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gtranslator/gtranslator-1.9.13.ebuild,v 1.1 2010/12/09 00:30:12 eva Exp $

EAPI="3"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="An enhanced gettext po file editor for GNOME"
HOMEPAGE="http://gtranslator.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc http gnome spell"

RDEPEND="
	>=dev-libs/glib-2.25.10:2
	>=dev-libs/gdl-2.26
	>=dev-libs/libunique-1
	>=dev-libs/libxml2-2.4.12
	gnome-base/gsettings-desktop-schemas
	gnome-extra/libgda:4
	>=x11-libs/gtk+-2.21.5:2
	>=x11-libs/gtksourceview-2.4:2.0

	gnome? (
		gnome-extra/gnome-utils
		>=gnome-extra/gucharmap-2 )
	http? ( >=dev-libs/json-glib-0.7.6 )
	spell? ( >=app-text/gtkspell-2.0.2 )"
DEPEND="${RDEPEND}
	>=app-text/scrollkeeper-0.1.4
	>=dev-util/intltool-0.40
	>=sys-devel/gettext-0.17
	dev-util/pkgconfig
	app-text/gnome-doc-utils
	app-text/docbook-xml-dtd:4.1.2
	doc? ( >=dev-util/gtk-doc-1 )"

pkg_setup() {
	DOCS="AUTHORS ChangeLog HACKING INSTALL NEWS README THANKS TODO"
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
	find "${ED}" -name "*.la" -delete || die "failed to remove *.la"
}
