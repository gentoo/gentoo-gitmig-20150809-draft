# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pylons/pylons-0.9.7.ebuild,v 1.1 2009/04/26 10:05:12 patrick Exp $

EAPI="1"

NEED_PYTHON=2.3

inherit distutils

KEYWORDS="~amd64 ~x86"

MY_PN=Pylons
MY_P=${MY_PN}-${PV}

DESCRIPTION="A lightweight web framework emphasizing flexibility and rapid development."
HOMEPAGE="http://pylonshq.com"
SRC_URI="http://cheeseshop.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"
LICENSE="BSD"
SLOT="0"
IUSE="cheetah genshi jinja2 kid +mako myghty doc"

RDEPEND=">=dev-python/routes-1.10.3
	>=dev-python/webhelpers-0.6.4
	>=dev-python/beaker-1.2.0
	>=dev-python/paste-1.7.2
	>=dev-python/pastedeploy-1.3.3
	>=dev-python/pastescript-1.7.3
	>=dev-python/formencode-1.2.1
	>=dev-python/simplejson-2.0.8
	>=dev-python/decorator-2.3.2
	>=dev-python/nose-0.10.4
	>=dev-python/webob-0.9.6.1
	>=dev-python/weberror-0.10.1
	>=dev-python/webtest-1.1
	>=dev-python/tempita-0.2
	cheetah? (
		>=dev-python/cheetah-1.0
		>=dev-python/turbocheetah-0.9.5
	)
	genshi? ( >=dev-python/genshi-0.4.4 )
	jinja2? ( dev-python/jinja2 )
	kid? (
		>=dev-python/kid-0.9
		>=dev-python/turbokid-0.9.1
	)
	mako? ( >=dev-python/mako-0.2.4 )
	myghty? ( >=dev-python/myghty-1.1 )"
DEPEND="${RDEPEND}
	dev-python/setuptools
	doc? ( dev-python/pudge dev-python/buildutils )"

# The tests fail, needs further investigation
RESTRICT="test"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	distutils_src_unpack

	sed -i \
		-e 's|dest =.*|dest = docs/html|' \
		setup.cfg || die "sed failed"
}

src_compile() {
	distutils_src_compile
	if use doc ; then
		einfo "Generating docs as requested..."
		"${python}" setup.py pudge || die "generating docs failed"
	fi
}

src_install() {
	distutils_src_install
	use doc && dohtml -r docs/html/*
}

pkg_postinst() {
	elog "pylons can make use of many other packages like:"
	elog " cheetah, genshi, kid or pudge"
}

src_test() {
	PYTHONPATH=. "${python}" setup.py nosetests || die "tests failed"
}
