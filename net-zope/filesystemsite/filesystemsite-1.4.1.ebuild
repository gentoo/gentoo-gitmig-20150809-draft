# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/filesystemsite/filesystemsite-1.4.1.ebuild,v 1.3 2005/02/21 21:23:54 blubb Exp $

inherit zproduct

DESCRIPTION="Zope proxy objects for files on the filesystem."
HOMEPAGE="http://www.zope.org/Members/infrae/FileSystemSite"
SRC_URI="${HOMEPAGE}/FileSystemSite-${PV}/FileSystemSite-${PV}.tgz"
LICENSE="ZPL"
KEYWORDS="x86 ~amd64"
IUSE=""

RDEPEND=">=net-zope/cmf-1.4.2
		${RDEPEND}"

ZPROD_LIST="FileSystemSite"
