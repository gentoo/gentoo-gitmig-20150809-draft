# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/marrie/marrie-0.3.ebuild,v 1.1 2012/11/22 04:39:08 rafaelmartins Exp $

EAPI=4
PYTHON_COMPAT=(python2_7)

inherit distutils-r1

DESCRIPTION="A simple podcast client that runs on the Command Line Interface"
HOMEPAGE="http://projects.rafaelmartins.eng.br/marrie/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/python-argparse
	dev-python/feedparser"
DEPEND="${RDEPEND}
	dev-python/docutils"

DOCS_HTML=(README.html)

src_compile() {
	rst2html.py README.rst README.html
	distutils-r1_src_compile
}
