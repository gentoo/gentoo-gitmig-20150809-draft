# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/glabels/glabels-2.2.8.ebuild,v 1.5 2010/10/10 17:53:04 armin76 Exp $

EAPI="2"
GCONF_DEBUG="no"

inherit eutils gnome2

DESCRIPTION="Program for creating labels and business cards"
HOMEPAGE="http://glabels.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2 FDL-1.1 LGPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="doc eds"

RDEPEND=">=dev-libs/glib-2.12
	>=x11-libs/gtk+-2.10
	>=gnome-base/libgnome-2.16
	>=gnome-base/libgnomeui-2.16
	>=dev-libs/libxml2-2.7
	>=gnome-base/libglade-2.6
	eds? ( >=gnome-extra/evolution-data-server-1.8 )"
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

	# Fix documentation misuse of entities, bug #?
	epatch "${FILESDIR}/${PN}-2.2.6-documentation.patch"

	# Fix malformed XML documentation, bug #?
	epatch "${FILESDIR}/${PN}-2.2.7-documentation.patch"

	# Fix intltool test, bug #?
	echo "help/cs/glabels.xml" >> po/POTFILES.in
}

src_install() {
	gnome2_src_install
	find "${D}" -name "*.la" -delete || die
}
