# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/spyder/spyder-1.0.3.ebuild,v 1.3 2010/07/22 17:45:08 arfrever Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
PYTHON_DEPEND="2:2.5"

inherit distutils

DESCRIPTION="Python IDE with matlab-like features"
HOMEPAGE="http://code.google.com/p/spyderlib/ http://pypi.python.org/pypi/spyder"
SRC_URI="http://spyderlib.googlecode.com/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="matplotlib mayavi numpy pylint scipy"

RDEPEND=">=dev-python/PyQt4-4.4
	>=dev-python/qscintilla-python-2.1
	matplotlib? ( dev-python/matplotlib )
	mayavi? ( sci-visualization/mayavi:2 )
	numpy? ( dev-python/numpy )
	pylint? ( dev-python/pylint )
	scipy? ( sci-libs/scipy )"
