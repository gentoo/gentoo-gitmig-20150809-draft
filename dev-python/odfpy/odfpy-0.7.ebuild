# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/odfpy/odfpy-0.7.ebuild,v 1.1 2009/04/18 19:20:45 patrick Exp $

NEED_PYTHON=2.4

inherit distutils

DESCRIPTION="Python interface to Open Document Format"
HOMEPAGE="http://opendocumentfellowship.com/development/projects/odfpy"
SRC_URI="http://pypi.python.org/packages/source/o/odfpy/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND="dev-python/setuptools"
IUSE=""
RDEPEND=""

src_install() {
	distutils_src_install
}
