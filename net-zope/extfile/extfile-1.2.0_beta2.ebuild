# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/extfile/extfile-1.2.0_beta2.ebuild,v 1.5 2004/07/19 22:24:55 kloeri Exp $

inherit zproduct
PV_NEW=${PV/_beta/b}

DESCRIPTION="Zope proxy objects for files on the filesystem"
HOMEPAGE="http://www.zope.org/Members/shh/ExtFile"
SRC_URI="${HOMEPAGE}/ExtFile-${PV_NEW}.tar.gz"
LICENSE="ZPL"
KEYWORDS="x86 ~ppc"
RDEPEND=">=dev-python/imaging-py21-1.1.3
	${RDEPEND}"

ZPROD_LIST="ExtFile"
