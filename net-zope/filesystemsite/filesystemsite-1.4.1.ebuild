# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/filesystemsite/filesystemsite-1.4.1.ebuild,v 1.5 2006/01/27 02:33:15 vapier Exp $

inherit zproduct

DESCRIPTION="Zope proxy objects for files on the filesystem"
HOMEPAGE="http://www.zope.org/Members/infrae/FileSystemSite"
SRC_URI="${HOMEPAGE}/FileSystemSite-${PV}/FileSystemSite-${PV}.tgz"

LICENSE="ZPL"
KEYWORDS="~amd64 ~ppc x86"

RDEPEND=">=net-zope/cmf-1.4.2"

ZPROD_LIST="FileSystemSite"
