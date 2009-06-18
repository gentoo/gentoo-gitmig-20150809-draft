# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/bpython/bpython-0.9.3.ebuild,v 1.1 2009/06/18 20:02:13 grozin Exp $

EAPI=2
PYTHON_USE_WITH=ncurses
inherit distutils
DESCRIPTION="Syntax highlighting and autocompletion for the python interpreter"
HOMEPAGE="http://www.${PN}-interpreter.org/"
SRC_URI="${HOMEPAGE}/releases/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="dev-python/setuptools"
# setuptools is needed at runtime for the wrapper script
RDEPEND="${DEPEND}
	dev-python/pygments"
DOCS="sample.ini sample.theme light.theme"
