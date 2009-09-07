# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ipdb/ipdb-0.1_p1716.ebuild,v 1.3 2009/09/07 06:55:54 arfrever Exp $

EAPI=2
inherit distutils

MY_PV="0.1dev-r1716"
DESCRIPTION="IPython-enabled pdb"
HOMEPAGE="http://pypi.python.org/pypi/ipdb"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${PN}-${MY_PV}.tar.gz"

IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"

RDEPEND=""
DEPEND="dev-python/setuptools"

S="${WORKDIR}"/${PN}-${MY_PV}
