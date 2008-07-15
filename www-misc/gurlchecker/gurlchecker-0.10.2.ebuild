# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/gurlchecker/gurlchecker-0.10.2.ebuild,v 1.3 2008/07/15 20:23:55 jer Exp $

inherit autotools eutils gnome2

DESCRIPTION="Gnome tool that checks links on web pages/sites"
HOMEPAGE="http://gurlchecker.labs.libre-entreprise.org/"
SRC_URI="http://labs.libre-entreprise.org/frs/download.php/623/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
SLOT="0"
IUSE="clamav doc gnutls tidy"

RDEPEND=">=x11-libs/gtk+-2.6
	>=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2
	>=dev-libs/libxml2-2.6
	>=net-libs/gnet-2
	>=dev-libs/libcroco-0.6
	tidy? ( app-text/htmltidy )
	clamav? ( app-antivirus/clamav )
	gnutls? ( >=net-libs/gnutls-1 )"

# docbook-sgml-utils used to build the man page
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.30
	app-text/docbook-sgml-utils
	dev-util/gtk-doc-am
	doc? ( >dev-util/gtk-doc-1.1 )"

DOCS="AUTHORS CONTRIBUTORS ChangeLog FAQ NEWS README THANKS TODO"

pkg_setup() {
	G2CONF="${G2CONF}
		--with-croco
		$(use_with tidy)
		$(use_with clamav)
		$(use_with gnutls)"
}

src_unpack() {
	gnome2_src_unpack

	# The file index.sgml should be distributed with the sources, but
	# it is not, causing problems. See bug #92784.
	touch "${S}"/doc/html/index.sgml

	# Fix compilation with clamav 0.93, bug #
	epatch "${FILESDIR}/${P}-clamav093.patch"

	# Fix bad yes/no detection
	epatch "${FILESDIR}/${P}-configure.in.patch"

	# Fix tidy.h include dir for Gentoo:
	epatch "${FILESDIR}/${P}-configure.in-2.patch"

	eautoreconf
}
