# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/elementtree/elementtree-1.2_beta3.ebuild,v 1.4 2004/10/22 02:53:02 pythonhead Exp $

inherit distutils

MY_P="${PN}-${PV/_beta/b}-20040602"
DESCRIPTION="A light-weight XML object model for Python"
HOMEPAGE="http://effbot.org/zone/element-index.htm"
SRC_URI="http://effbot.org/downloads/${MY_P}.zip"
KEYWORDS="x86 ~ppc"
DEPEND="virtual/python"
RDEPEND="${DEPEND}
	app-arch/unzip"
LICENSE="as-is"
SLOT="0"
IUSE=""
DOCS="CHANGES"
S=${WORKDIR}/${MY_P}

# The archive is correct, but default src_unpack function doesn't 
# work as unzip returns code 1 because of some warning.
src_unpack() {
	unzip -qo "${DISTDIR}/${A}"
}

