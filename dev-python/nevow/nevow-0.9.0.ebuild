# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/nevow/nevow-0.9.0.ebuild,v 1.1 2006/07/04 15:33:43 marienz Exp $

inherit distutils

DESCRIPTION="A web templating framework that provides LivePage, an automatic AJAX toolkit."
HOMEPAGE="http://divmod.org/trac/wiki/DivmodNevow"
SRC_URI="mirror://gentoo/Nevow-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="doc"

DEPEND=">=dev-lang/python-2.4
	>=dev-python/twisted-2.4
	dev-python/twisted-web
	doc? ( dev-python/docutils )"

S=${WORKDIR}/Nevow-${PV}

PYTHON_MODNAME="nevow formless"

src_test() {
	PYTHONPATH=. trial nevow || die "nevow trial failed"
	PYTHONPATH=. trial formless || die "formless trial failed"
}

src_compile() {
	distutils_src_compile
	if use doc; then
		cd doc
		python make.py || die "documentation building failed"
	fi
}

src_install() {
	distutils_src_install
	if use doc; then
		insinto /usr/share/doc/${PF}/
		doins -r doc/txt doc/html examples
	fi
}
