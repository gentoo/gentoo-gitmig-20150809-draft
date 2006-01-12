# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/portaltransforms/portaltransforms-1.3.3.ebuild,v 1.4 2006/01/12 21:52:25 robbat2 Exp $

inherit zproduct

MY_PN="PortalTransforms"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="MIME-type based transformations for Archetypes"
HOMEPAGE="http://www.sf.net/projects/archetypes"
SRC_URI="mirror://sourceforge/archetypes/${MY_P}-final.tar.gz"
LICENSE="GPL-1"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
SLOT="1.3"
IUSE=""

ZPROD_LIST="${MY_PN}"

MYDOC="${MYDOC} TODO README LICENSE.txt ChangeLog"

RDEPEND=">=net-zope/cmf-1.4.7
		app-text/htmltidy
		app-text/wv
		dev-libs/libxslt
		app-text/xlhtml
		app-text/unrtf
		dev-python/docutils
		www-client/lynx
		|| ( app-text/pdftohtml app-text/poppler )"

src_install()
{
	zproduct_src_install all
}

