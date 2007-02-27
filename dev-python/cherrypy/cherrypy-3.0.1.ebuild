# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cherrypy/cherrypy-3.0.1.ebuild,v 1.1 2007/02/27 21:10:21 lucass Exp $

inherit distutils

MY_P=CherryPy-${PV}

DESCRIPTION="CherryPy is a pythonic, object-oriented web development framework."
SRC_URI="http://download.cherrypy.org/cherrypy/${PV}/${MY_P}.tar.gz"
HOMEPAGE="http://www.cherrypy.org/"
IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
LICENSE="BSD"

S="${WORKDIR}/${MY_P}"

src_test() {
	cd cherrypy/test
	${python} test.py --dumb || die "Test failed."
}
