# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/fle3/fle3-1.4.2.ebuild,v 1.6 2004/08/08 00:36:06 slarti Exp $

inherit zproduct
P_NEW="fle_${PV}"

DESCRIPTION="Future Learning Environment for collaborative learning"
HOMEPAGE="http://fle3.uiah.fi/"
SRC_URI="${HOMEPAGE}/download/${P_NEW}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
RDEPEND="dev-python/imaging-py21
	${RDEPEND}"

ZPROD_LIST="FLE"
