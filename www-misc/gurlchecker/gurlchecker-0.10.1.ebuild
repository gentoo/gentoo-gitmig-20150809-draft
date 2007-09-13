# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/gurlchecker/gurlchecker-0.10.1.ebuild,v 1.1 2007/09/13 00:18:48 leonardop Exp $

inherit eutils gnome2

DESCRIPTION="Gnome tool that checks links on web pages/sites"
HOMEPAGE="http://gurlchecker.labs.libre-entreprise.org/"
SRC_URI="http://labs.libre-entreprise.org/frs/download.php/547/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~ppc ~x86"
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
	doc? ( >dev-util/gtk-doc-1.1 )"

DOCS="AUTHORS CONTRIBUTORS ChangeLog FAQ NEWS README THANKS TODO"


pkg_setup() {
	G2CONF="--with-croco \
		$(use_with tidy)   \
		$(use_with clamav) \
		$(use_with gnutls)"
}

src_unpack() {
	unpack "${A}"

	# Leave the LDFLAGS alone, appending $withval is utterly broken
	epatch "${FILESDIR}/${P}-ldflags.patch"

	# The file index.sgml should be distributed with the sources, but
	# it is not, causing problems. See bug #92784.
	touch ${S}/doc/html/index.sgml
}
