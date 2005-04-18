# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/elementtree/elementtree-1.2.ebuild,v 1.5 2005/04/18 17:59:05 pythonhead Exp $

inherit distutils

MY_P="${PN}-${PV}-20040618"
DESCRIPTION="A light-weight XML object model for Python"
HOMEPAGE="http://effbot.org/zone/element-index.htm"
SRC_URI="http://effbot.org/downloads/${MY_P}.tar.gz"
KEYWORDS="x86 ~ppc"
LICENSE="as-is"
SLOT="0"
IUSE=""
S=${WORKDIR}/${MY_P}

src_install() {
	distutils_src_install

	dodoc CHANGES
	dohtml docs/*
}
