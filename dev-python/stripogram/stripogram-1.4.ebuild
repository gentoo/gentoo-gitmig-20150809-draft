# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/stripogram/stripogram-1.4.ebuild,v 1.7 2004/05/04 12:38:21 kloeri Exp $

inherit distutils
P_NEW="${PN}-${PV/\./-}"
S=${WORKDIR}/${PN}

DESCRIPTION="A library for converting HTML to Plain Text."
HOMEPAGE="http://www.zope.org/Members/chrisw/StripOGram/"
SRC_URI="http://www.zope.org/Members/chrisw/StripOGram/${P_NEW}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""
