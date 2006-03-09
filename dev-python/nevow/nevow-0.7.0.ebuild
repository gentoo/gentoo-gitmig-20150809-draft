# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/nevow/nevow-0.7.0.ebuild,v 1.4 2006/03/09 20:04:06 kugelfang Exp $

inherit distutils

DESCRIPTION="A web templating framework that provides LivePage, an automatic AJAX toolkit."
HOMEPAGE="http://divmod.org/trac/wiki/DivmodNevow"
SRC_URI="mirror://gentoo/Nevow-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="doc test"

DEPEND=">=dev-lang/python-2.4
	test? ( dev-python/twisted )
	doc? ( dev-python/docutils )"

S=${WORKDIR}/Nevow-${PV}

PYTHON_MODNAME="nevow formless"

src_test() {
	local trialopts
	if ! has_version ">=dev-python/twisted-2.1"; then
		trialopts=-R
	fi
	trial ${trialopts} nevow || die "nevow trial failed"
	trial ${trialopts} formless || die "formless trial failed"
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

# "fix" a distutils.eclass buglet: PYTHON_MODNAME shouldn't be quoted

pkg_postinst() {
	if has_version ">=dev-lang/python-2.3"; then
		python_version
		for pymod in ${PYTHON_MODNAME}; do
			if [ -d "${ROOT}usr/$(get_libdir)/python${PYVER}/site-packages/${pymod}" ]; then
				python_mod_optimize ${ROOT}usr/$(get_libdir)/python${PYVER}/site-packages/${pymod}
			fi
		done
	fi
}
