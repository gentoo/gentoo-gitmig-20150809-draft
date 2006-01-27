# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/extfile/extfile-1.4.2.ebuild,v 1.2 2006/01/27 02:32:33 vapier Exp $

inherit zproduct

DESCRIPTION="Zope proxy objects for files on the filesystem"
HOMEPAGE="http://www.zope.org/Members/shh/ExtFile"
SRC_URI="${HOMEPAGE}/${PV}/ExtFile-${PV}.tar.gz"

LICENSE="ZPL"
KEYWORDS="~ppc ~x86"

RDEPEND=">=dev-python/imaging-1.1.3"

ZPROD_LIST="ExtFile"
