# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/turbogears/turbogears-1.0.1.ebuild,v 1.5 2007/07/04 19:39:14 pythonhead Exp $

NEED_PYTHON=2.4

inherit distutils

KEYWORDS="~amd64 ~x86"

MY_PN=TurboGears
MY_P=${MY_PN}-${PV}

DESCRIPTION="the rapid web development megaframework you've been looking for."
HOMEPAGE="http://www.turbogears.org/"
SRC_URI="http://files.turbogears.org/eggs/${MY_P}.tar.gz"
LICENSE="MIT"
SLOT="0"
IUSE="test"

RDEPEND=">=dev-python/turbojson-1.0
	>=dev-python/turbocheetah-0.9.5
	>=dev-python/turbokid-0.9.8
	=dev-python/cherrypy-2.2*
	>=dev-python/simplejson-1.3
	>=dev-python/elementtree-1.2.6
	>=dev-python/pastescript-0.9.7
	>=dev-python/celementtree-1.0.5
	>=dev-python/formencode-0.5.1
	dev-python/ruledispatch
	>=dev-python/configobj-4.3.2
	|| ( =dev-python/sqlobject-0.7* >=dev-python/sqlalchemy-0.3.3 )
	>=dev-python/genshi-0.3.6
	test? ( >=dev-python/nose-0.9 >=dev-python/sqlalchemy-0.3.3 )"
DEPEND="${RDEPEND}
	dev-python/setuptools"

S=${WORKDIR}/${MY_P}

DOCS="CHANGELOG.txt CONTRIBUTORS.txt"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/use_setuptools/d' \
		setup.py || die "sed failed"
}

src_test() {
	PYTHONPATH=. "${python}" setup.py test || die "tests failed"
	PYTHONPATH=. "${python}" setup.py nosetests || die "nosetests failed"
}
