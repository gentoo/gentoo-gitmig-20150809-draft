# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/gurlchecker/gurlchecker-0.8.3.ebuild,v 1.1 2005/12/22 03:24:01 leonardop Exp $

inherit gnome2

DESCRIPTION="Gnome tool that checks links on web pages/sites"
HOMEPAGE="http://gurlchecker.labs.libre-entreprise.org/"
SRC_URI="http://labs.libre-entreprise.org/frs/download.php/423/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~ppc ~x86"
SLOT="0"
IUSE="doc gnutls"

RDEPEND=">=dev-libs/glib-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2
	>=dev-libs/libxml2-2.6
	>=net-libs/gnet-2
	gnutls? ( >=net-libs/gnutls-1 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.30
	doc? ( >dev-util/gtk-doc-1.1 )"

DOCS="ABOUT-NLS AUTHORS ChangeLog FAQ NEWS README THANKS TODO"


pkg_setup() {
	G2CONF="$(use_with gnutls)"
}

src_unpack() {
	unpack ${A}
	# The file index.sgml should be distributed with the sources, but
	# it is not, causing problems. See bug #92784.
	touch ${S}/doc/html/index.sgml
}
