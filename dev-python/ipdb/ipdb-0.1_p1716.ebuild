# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ipdb/ipdb-0.1_p1716.ebuild,v 1.1 2009/04/04 10:59:59 hollow Exp $

EAPI=2
inherit distutils

MY_PV="0.1dev-r1716"
DESCRIPTION="Interactive plotting toolkit"
HOMEPAGE="http://code.enthought.com/projects/chaco"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${PN}-${MY_PV}.tar.gz"

IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"

RDEPEND=""
DEPEND=""

S="${WORKDIR}"/${PN}-${MY_PV}
