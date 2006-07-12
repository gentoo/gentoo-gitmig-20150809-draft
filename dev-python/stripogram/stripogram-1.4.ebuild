# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/stripogram/stripogram-1.4.ebuild,v 1.10 2006/07/12 16:59:09 agriffis Exp $

inherit distutils
P_NEW="${PN}-${PV/\./-}"
S=${WORKDIR}/${PN}

DESCRIPTION="A library for converting HTML to Plain Text."
HOMEPAGE="http://www.zope.org/Members/chrisw/StripOGram/"
SRC_URI="http://www.zope.org/Members/chrisw/StripOGram/${P_NEW}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="ia64 ppc x86"
IUSE=""
