 
# Copyright 2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/extfile/extfile-1.2.0_beta1.ebuild,v 1.1 2003/04/11 08:17:52 kutsuya Exp $

inherit zproduct
PV_NEW=${PV/_beta/b}

DESCRIPTION="Zope proxy objects for files on the filesystem"
HOMEPAGE="http://www.zope.org/Members/shh/ExtFile"
SRC_URI="${HOMEPAGE}/ExtFile-${PV_NEW}.tar.gz"
LICENSE="ZPL"
KEYWORDS="~x86 ~ppc"
RDEPEND=">=dev-python/Imaging-py21-1.1.3
	${RDEPEND}"

ZPROD_LIST="ExtFile"
