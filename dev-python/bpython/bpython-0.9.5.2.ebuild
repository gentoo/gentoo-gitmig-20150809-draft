# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/bpython/bpython-0.9.5.2.ebuild,v 1.1 2009/10/02 01:51:18 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"
PYTHON_USE_WITH="ncurses"

inherit distutils

DESCRIPTION="Syntax highlighting and autocompletion for the Python interpreter"
HOMEPAGE="http://www.bpython-interpreter.org/"
SRC_URI="http://www.bpython-interpreter.org/releases/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools"
# setuptools is needed at runtime for the wrapper script
RDEPEND="${DEPEND}
	dev-python/pygments"

DOCS="sample-config sample.theme light.theme"
