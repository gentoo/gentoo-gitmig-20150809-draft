# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zphotoslides/zphotoslides-1.1.ebuild,v 1.3 2004/06/25 01:27:14 agriffis Exp $

inherit zproduct

DESCRIPTION="Present your photos quickly in zope."
HOMEPAGE="http://www.zope.org/Members/p3b/ZPhotoSlides"
SRC_URI="${HOMEPAGE}/ZPhotoSlides-${PV}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
RDEPEND=">=dev-python/Imaging-py21-1.1.3
	>=net-zope/localfs-1.0.0
	${RDEPEND}"

ZPROD_LIST="ZPhotoSlides"
DOTTXT_PROTECT="country-codes.txt ${DOTTXT_PROTECT}"
