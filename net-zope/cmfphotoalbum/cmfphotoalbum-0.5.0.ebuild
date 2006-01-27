# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/cmfphotoalbum/cmfphotoalbum-0.5.0.ebuild,v 1.4 2006/01/27 06:28:57 mr_bones_ Exp $

inherit zproduct

DESCRIPTION="Zope/CMF product to organize e-pics into hierarchical photo album"
HOMEPAGE="http://sourceforge.net/projects/collective/"
SRC_URI="mirror://sourceforge/collective/CMFPhotoAlbum-${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~ppc x86"

RDEPEND="=net-zope/cmfphoto-${PV}*
	>=net-zope/btreefolder2-0.5.0"

ZPROD_LIST="CMFPhotoAlbum"

pkg_postinst() {
	zproduct_pkg_postinst
	ewarn "Please use CMFQuickInstallerTool or read the documentation of this"
	ewarn "product for instruction on how to add this product to your CMF/Plone site."
}
