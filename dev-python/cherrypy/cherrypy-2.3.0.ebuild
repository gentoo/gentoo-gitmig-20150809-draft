# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cherrypy/cherrypy-2.3.0.ebuild,v 1.2 2009/02/15 14:31:56 patrick Exp $

inherit eutils distutils

MY_P=CherryPy-${PV}

DESCRIPTION="CherryPy is a pythonic, object-oriented web development framework."
SRC_URI="http://download.cherrypy.org/cherrypy/${PV}/${MY_P}.tar.gz"
HOMEPAGE="http://www.cherrypy.org/"
IUSE="doc test"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"

DEPEND="dev-python/setuptools
	test? ( >=dev-python/webtest-1.0 )
	app-arch/unzip"
RDEPEND=""

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"

	#Remove test_cache_filter, only works outside of portage
	sed -i \
		-e '/raw_input/d' \
		-e "/'test_cache_filter',/d" \
		cherrypy/test/test.py || die "sed failed"
	sed -i \
		-e 's/"cherrypy.tutorial",//' \
		-e "/('cherrypy\/tutorial',/, /),/d" \
		-e 's/distutils.core/setuptools/' \
		setup.py || die "sed failed"
}

src_install() {
	distutils_src_install
	if use doc ; then
		insinto /usr/share/doc/${PF}
		doins -r cherrypy/tutorial
	fi
}

src_test() {
	PYTHONPATH=. "${python}" cherrypy/test/test.py || die "test failed"
}
