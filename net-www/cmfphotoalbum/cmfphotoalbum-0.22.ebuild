# Copyright 2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public Form License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/cmfphotoalbum/cmfphotoalbum-0.22.ebuild,v 1.1 2003/02/28 02:49:32 kutsuya Exp $

inherit zproduct

DESCRIPTION="Zope/CMF product to organize e-pics into hierarchical photo album."
HOMEPAGE="http://www.zope.org/Members/bowerymarc/CMFPhotoAlbum/"
SRC_URI="${HOMEPAGE}/CMFPhotoAlbum-${PV}.tar.gz"
S="${WORKDIR}/lib/python/Products/"
LICENSE="GPL"
KEYWORDS="~x86"
RDEPEND="=net-www/cmf-1.3*
	    >=net-www/btreefolder2-0.5.0
	    ${RDEPEND}"

ZPROD_LIST="CMFPhotoAlbum"

