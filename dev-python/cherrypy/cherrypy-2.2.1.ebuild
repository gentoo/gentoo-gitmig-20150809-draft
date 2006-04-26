# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cherrypy/cherrypy-2.2.1.ebuild,v 1.1 2006/04/26 01:42:09 pythonhead Exp $

inherit distutils eutils

MY_P=${P/cherrypy/CherryPy}

DESCRIPTION="CherryPy is a pythonic, object-oriented web development framework."
SRC_URI="mirror://sourceforge/cherrypy/${MY_P}.tar.gz"
HOMEPAGE="http://www.cherrypy.org/"
DEPEND=">=dev-lang/python-2.3"
IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
LICENSE="BSD"
S=${WORKDIR}/${MY_P}

DOCS="CHANGELOG.txt CHERRYPYTEAM.txt"

src_unpack() {
	unpack ${A} || die
	cd ${S}
	epatch ${FILESDIR}/${P}-test-gentoo.patch
}

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${P}
	doins -r cherrypy/tutorial
	insinto /usr/share/${PN}
	doins -r cherrypy/test
}

src_test() {
	cd cherrypy/test
	python test.py || die "Test failed."
}

