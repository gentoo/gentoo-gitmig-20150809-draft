# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/nevow/nevow-0.9.31.ebuild,v 1.2 2008/05/14 17:07:44 hawking Exp $

NEED_PYTHON="2.4"

inherit distutils multilib

MY_P="Nevow-${PV}"

DESCRIPTION="A web templating framework that provides LivePage, an automatic AJAX toolkit."
HOMEPAGE="http://divmod.org/trac/wiki/DivmodNevow"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="doc"

RDEPEND=">=dev-python/twisted-2.5
	dev-python/twisted-web"
DEPEND="${RDEPEND}
	doc? ( dev-python/docutils )"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="nevow formless"

src_compile() {
	distutils_src_compile
	if use doc; then
		cd doc
		"${python}" make.py || die "documentation building failed"
	fi
}

src_install() {
	distutils_src_install
	# mantisia expects js to be under site-packages/
	# but setup.py doesn't install it
	python_version
	insinto /usr/$(get_libdir)/python${PYVER}/site-packages/${PN}
	doins ${PN}/*.js || die "doins failed"
	doins -r ${PN}/js || die "doins failed"
	if use doc; then
		insinto /usr/share/doc/${PF}/
		doins -r doc/txt doc/html examples
	fi
}

src_test() {
	PYTHONPATH="." trial nevow || die "nevow trial failed"
	PYTHONPATH="." trial formless || die "formless trial failed"
}
