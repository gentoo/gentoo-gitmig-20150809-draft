# Copyright 2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/stripogram/stripogram-1.4.ebuild,v 1.1 2003/04/08 08:19:13 kutsuya Exp $

inherit distutils
P_NEW="${PN}-${PV/\./-}"
S=${WORKDIR}/${PN}

DESCRIPTION="A library for converting HTML to Plain Text."
HOMEPAGE="http://www.zope.org/Members/chrisw/StripOGram/"
SRC_URI="${HOMEPAGE}/${P_NEW}.tgz"
SLOT="0"
KEYWORDS="~x86 ~ppc"
LICENSE="MIT"
IUSE=""

