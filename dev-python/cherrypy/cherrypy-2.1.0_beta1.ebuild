# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cherrypy/cherrypy-2.1.0_beta1.ebuild,v 1.2 2005/07/17 01:04:18 pythonhead Exp $

inherit distutils

MY_P=${P/c/C}
MY_P=${MY_P/p/P}
MY_P=${MY_P/_beta1/-beta}

DESCRIPTION="CherryPy is a pythonic, object-oriented web development framework."
SRC_URI="mirror://sourceforge/cherrypy/${MY_P}.tar.gz"
HOMEPAGE="http://www.cherrypy.org/"
DEPEND=">=dev-lang/python-2.3"
IUSE=""
SLOT="0"
KEYWORDS="~x86 ~ppc"
LICENSE="BSD"
S=${WORKDIR}/${MY_P}

DOCS="CHANGELOG.txt CHERRYPYTEAM.txt"

src_unpack() {
	unpack ${A} || die
	cd ${S}
	epatch ${FILESDIR}/${P}-setup-gentoo.diff
	epatch ${FILESDIR}/${P}-test-gentoo.diff
}

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${P}
	doins -r cherrypy/tutorial
	insinto /usr/share/${PN}
	doins -r cherrypy/test
	dosym /usr/share/doc/${P}/tutorial /usr/share/${PN}
}

src_test() {
	cd cherrypy/test
	python test.py || die "Test failed."
}

pkg_postinst() {
	einfo ""
	einfo "Tutorial files: /usr/share/doc/${P}/tutorial"
	einfo "Test files    : /usr/share/${PN}/test"
	einfo ""
}
