# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/networkx/networkx-0.99.ebuild,v 1.1 2009/02/28 19:40:26 bicatali Exp $

EAPI=2
NEED_PYTHON=2.4
inherit eutils distutils

DESCRIPTION="Python tools to manipulate graphs and complex networks"
HOMEPAGE="http://networkx.lanl.gov"
SRC_URI="http://networkx.lanl.gov/download/networkx/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="LGPL-2.1"
IUSE="examples"

DEPEND="dev-python/setuptools"
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-setup.py.patch
}

src_install() {
	distutils_src_install
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples || die
	fi
}
