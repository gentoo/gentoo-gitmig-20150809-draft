# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/fle3/fle3-1.4.2.ebuild,v 1.8 2006/01/27 02:33:35 vapier Exp $

inherit zproduct

P_NEW="fle_${PV}"
DESCRIPTION="Future Learning Environment for collaborative learning"
HOMEPAGE="http://fle3.uiah.fi/"
SRC_URI="${HOMEPAGE}/download/${P_NEW}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~ppc x86"

RDEPEND="dev-python/imaging"

ZPROD_LIST="FLE"
