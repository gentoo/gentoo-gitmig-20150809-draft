# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/cmfphotoalbum/cmfphotoalbum-0.5.0.ebuild,v 1.5 2010/09/17 16:46:00 arfrever Exp $

inherit zproduct

DESCRIPTION="Zope/CMF product to organize e-pics into hierarchical photo album"
HOMEPAGE="http://sourceforge.net/projects/collective/"
SRC_URI="mirror://sourceforge/collective/CMFPhotoAlbum-${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~ppc x86"

RDEPEND="=net-zope/cmfphoto-${PV}*
	|| ( =net-zope/zope-2.10* =net-zope/zope-2.9* =net-zope/zope-2.8* )"

ZPROD_LIST="CMFPhotoAlbum"

pkg_postinst() {
	zproduct_pkg_postinst
	ewarn "Please use CMFQuickInstallerTool or read the documentation of this"
	ewarn "product for instruction on how to add this product to your CMF/Plone site."
}
