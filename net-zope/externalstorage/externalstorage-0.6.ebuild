# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/externalstorage/externalstorage-0.6.ebuild,v 1.1 2006/12/28 23:45:46 radek Exp $

inherit zproduct

DESCRIPTION="Plone add-on product which provides an extra storage for Archetypes."
HOMEPAGE="http://plone.org/products/externalstorage/"
SRC_URI="http://plone.org/products/externalstorage/releases/${PV}/ExternalStorage-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND=">=net-zope/archetypes-1.3.4"

ZPROD_LIST="ExternalStorage"

S="${S}/ExternalStorage-${PV}"

src_install() {
	zproduct_src_install all
}
