# Copyright 2002-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/filesystemsite/filesystemsite-1.2.ebuild,v 1.1 2003/03/25 11:42:15 kutsuya Exp $

inherit zproduct

DESCRIPTION="Zope proxy objects for files on the filesystem."
HOMEPAGE="http://www.zope.org/Members/k_vertigo/Products/FileSystemSite"
SRC_URI="${HOMEPAGE}/FileSystemSite-${PV}.tgz"
LICENSE="ZPL"
KEYWORDS="~x86 ~ppc"

ZPROD_LIST="FileSystemSite"
