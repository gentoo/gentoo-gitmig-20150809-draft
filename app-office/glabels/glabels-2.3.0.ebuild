# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/glabels/glabels-2.3.0.ebuild,v 1.1 2010/09/26 21:59:11 eva Exp $

EAPI="2"
GCONF_DEBUG="no"

inherit eutils gnome2

DESCRIPTION="Program for creating labels and business cards"
HOMEPAGE="http://glabels.sourceforge.net/"

LICENSE="GPL-2 FDL-1.1 LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="barcode doc eds"

RDEPEND=">=dev-libs/glib-2.24:2
	>=x11-libs/gtk+-2.20:2
	>=dev-libs/libxml2-2.7
	>=gnome-base/gconf-2.28
	barcode? (
		>=app-text/barcode-0.98
		>=media-gfx/qrencode-3.1 )
	eds? ( >=gnome-extra/evolution-data-server-2.28 )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	app-text/scrollkeeper
	app-text/gnome-doc-utils
	app-text/docbook-xml-dtd:4.1.2
	>=dev-util/intltool-0.28
	doc? ( dev-util/gtk-doc )"

DOCS="AUTHORS ChangeLog NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF}
		$(use_with eds libebook)
		--disable-update-mimedb
		--disable-update-desktopdb
		--disable-static"
}

src_prepare() {
	gnome2_src_prepare

	# Fix malformed XML documentation, bug #?
	epatch "${FILESDIR}/${PN}-2.2.7-documentation.patch"

	# Fix intltool test, bug #?
	echo "help/cs/glabels-3.0.xml" >> po/POTFILES.in
}

src_install() {
	gnome2_src_install
	find "${D}" -name "*.la" -delete || die
}
