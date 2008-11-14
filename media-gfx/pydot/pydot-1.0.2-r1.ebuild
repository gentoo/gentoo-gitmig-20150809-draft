# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pydot/pydot-1.0.2-r1.ebuild,v 1.3 2008/11/14 11:00:06 aballier Exp $

inherit distutils eutils

DESCRIPTION="Python bindings for Graphviz"
HOMEPAGE="http://code.google.com/p/pydot/"
SRC_URI="http://pydot.googlecode.com/files/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-python/pyparsing
	media-gfx/graphviz"

PYTHON_MODNAME="pydot.py dot_parser.py"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-setup.patch
}
