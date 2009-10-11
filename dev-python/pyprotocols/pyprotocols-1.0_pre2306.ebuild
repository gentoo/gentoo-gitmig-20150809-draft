# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyprotocols/pyprotocols-1.0_pre2306.ebuild,v 1.6 2009/10/11 10:54:18 grobian Exp $

NEED_PYTHON=2.4

inherit distutils

MY_PN=PyProtocols
MY_P=${MY_PN}-${PV/_pre/a0dev_r}

DESCRIPTION="Extends the PEP 246 adapt() function with a new 'declaration API' that lets you easily define your own protocols and adapters, and declare what adapters should be used to adapt what types, objects, or protocols."
HOMEPAGE="http://peak.telecommunity.com/PyProtocols.html"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86 ~amd64-linux ~x86-linux ~x86-macos"
LICENSE="|| ( PSF-2.4 ZPL )"
SLOT="0"
IUSE=""

RDEPEND=">=dev-python/decoratortools-1.4"
DEPEND="${RDEPEND}
	>=dev-python/setuptools-0.6_rc5"

S="${WORKDIR}/${MY_PN}"

PYTHON_MODNAME="protocols"

src_test() {
	PYTHONPATH="./src/" "${python}" setup.py test || die "tests failed"
}
