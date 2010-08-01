# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-user-docs/gnome-user-docs-2.30.1.ebuild,v 1.5 2010/08/01 12:10:16 fauli Exp $

EAPI=2

GCONF_DEBUG="no"

inherit gnome2 eutils

DESCRIPTION="GNOME end user documentation"
HOMEPAGE="http://www.gnome.org/"

LICENSE="FDL-1.1"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd"
IUSE="test"

RDEPEND=""
DEPEND="app-text/scrollkeeper
	>=app-text/gnome-doc-utils-0.5.6
	>=dev-util/pkgconfig-0.9
	test? (
		~app-text/docbook-xml-dtd-4.1.2
		~app-text/docbook-xml-dtd-4.3 )"

DOCS="AUTHORS ChangeLog NEWS README"

# FIXME: Parallel make is badly broken, bug #260827 and #296375
#MAKEOPTS="${MAKEOPTS} -j1"

pkg_setup() {
	G2CONF="${G2CONF} --disable-scrollkeeper"
}

src_prepare() {
	gnome2_src_prepare

	# Fix XML syntax error in French translation
	epatch "${FILESDIR}/${P}-fr_FR.patch"
}
