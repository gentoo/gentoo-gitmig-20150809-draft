# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/extfile/extfile-1.4.2.ebuild,v 1.1 2004/10/23 22:50:32 lanius Exp $

inherit zproduct

DESCRIPTION="Zope proxy objects for files on the filesystem"
HOMEPAGE="http://www.zope.org/Members/shh/ExtFile"
SRC_URI="${HOMEPAGE}/${PV}/ExtFile-${PV}.tar.gz"
LICENSE="ZPL"
KEYWORDS="~x86 ~ppc"
RDEPEND=">=dev-python/imaging-1.1.3
	${RDEPEND}"

ZPROD_LIST="ExtFile"
IUSE=""
