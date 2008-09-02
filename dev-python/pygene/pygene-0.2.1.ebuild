# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygene/pygene-0.2.1.ebuild,v 1.2 2008/09/02 21:03:11 pythonhead Exp $

NEED_PYTHON=2.4

inherit distutils

DESCRIPTION="Simple python genetic algorithms programming library"
SRC_URI="http://www.freenet.org.nz/python/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.freenet.org.nz/python/pygene/"
SLOT="0"
KEYWORDS="~x86"
LICENSE="GPL-2"
IUSE="doc examples"
DEPEND="doc? ( >=dev-python/epydoc-2.1-r2 )"
RDEPEND="examples? ( >=dev-python/pyfltk-1.1.2 )"

DOCS="BUGS CREDITS INSTALL"

src_compile() {

	distutils_src_compile

	if use doc ; then
		epydoc -n "pygene - Python genetic algorithms" -o "${S}"/doc \
			"${S}"/pygene || die "epydoc failed"
	fi

}

src_install() {

	distutils_src_install

	use doc && \
		dohtml -r doc/*

	if use examples ; then
		insinto /usr/share/doc/"${PF}"/examples
		doins demo*.py salesman.gif || die 'doins failed'
	fi
}
