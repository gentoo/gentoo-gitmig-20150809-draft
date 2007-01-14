# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/filesystemsite/filesystemsite-1.4.2.ebuild,v 1.1 2007/01/14 10:46:31 radek Exp $

inherit zproduct

DESCRIPTION="Zope proxy objects for files on the filesystem"
HOMEPAGE="http://www.infrae.com/download/FileSystemSite"
SRC_URI="${HOMEPAGE}/${PV}/FileSystemSite-${PV}.tgz"

LICENSE="ZPL"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND=">=net-zope/cmf-1.4.2"

ZPROD_LIST="FileSystemSite"
