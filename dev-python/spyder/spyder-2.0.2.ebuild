# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/spyder/spyder-2.0.2.ebuild,v 1.1 2010/12/03 11:30:22 grozin Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.*"

inherit distutils

MY_PV="${PV/_/}"
MY_P=${PN}-${MY_PV}

DESCRIPTION="Python IDE with matlab-like features"
HOMEPAGE="http://code.google.com/p/spyderlib/ http://pypi.python.org/pypi/spyder/"
SRC_URI="http://spyderlib.googlecode.com/files/${MY_P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ipython matplotlib numpy +pyflakes pylint +rope scipy"

RDEPEND=">=dev-python/PyQt4-4.4[webkit]
	pyflakes? ( >=dev-python/pyflakes-0.3 )
	rope? ( >=dev-python/rope-0.9.0 )
	ipython? ( =dev-python/ipython-0.10 )
	matplotlib? ( dev-python/matplotlib )
	numpy? ( dev-python/numpy )
	pylint? ( dev-python/pylint )
	scipy? ( sci-libs/scipy )"

PYTHON_MODNAME="spyderlib spyderplugins"

S="${WORKDIR}/${MY_P}"
