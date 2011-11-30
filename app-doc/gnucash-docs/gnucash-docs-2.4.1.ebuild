# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/gnucash-docs/gnucash-docs-2.4.1.ebuild,v 1.2 2011/11/30 19:39:23 mr_bones_ Exp $

EAPI="4"
GCONF_DEBUG=no

inherit gnome2

DESCRIPTION="Documentation package for GnuCash"
HOMEPAGE="http://www.gnucash.org/"
SRC_URI="mirror://sourceforge/gnucash/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2 FDL-1.1"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"

IUSE=""

RDEPEND="gnome-extra/yelp
	!<=app-office/gnucash-2.2.1"

DEPEND="${RDEPEND}
	>=dev-libs/libxml2-2.5.10:2
	dev-libs/libxslt
	>=app-text/scrollkeeper-0.3.4
	app-text/docbook-xsl-stylesheets
	app-text/docbook-xml-dtd:4.1.2"

pkg_postinst() {
	gnome2_pkg_postinst

	if ! has_version "dev-java/fop"; then
		elog "You need dev-java/fop to generate pdf files."
	fi
}
