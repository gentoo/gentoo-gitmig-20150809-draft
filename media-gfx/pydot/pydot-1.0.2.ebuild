# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pydot/pydot-1.0.2.ebuild,v 1.2 2008/06/10 22:25:18 cedk Exp $

inherit distutils

DESCRIPTION="Python bindings for Graphviz"
HOMEPAGE="http://code.google.com/p/pydot/"
SRC_URI="http://pydot.googlecode.com/files/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-python/pyparsing
	media-gfx/graphviz"

PYTHON_MODNAME="pydot.py dot_parser.py"
