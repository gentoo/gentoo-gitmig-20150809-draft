# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ipython/ipython-0.7.3.ebuild,v 1.2 2007/02/03 10:55:56 dev-zero Exp $

NEED_PYTHON=2.3

inherit distutils

DESCRIPTION="An advanced interactive shell for Python."
HOMEPAGE="http://ipython.scipy.org/"
SRC_URI="http://ipython.scipy.org/dist/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~s390 ~x86"
IUSE="doc examples emacs gnuplot test"

DEPEND="test? ( dev-python/pexpect )"
RDEPEND="gnuplot? ( dev-python/gnuplot-py )"

PYTHON_MODNAME="IPython"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e '/examfiles/d' -e '/examples/d' \
		-e "/'manual'/d" -e '/manfiles)/d' \
		-e 's/^docfiles.*/docfiles=""/' \
		setup.py || die "sed failed"
}

src_install() {
	DOCS="doc/ChangeLog"
	distutils_src_install

	cd doc
	insinto /usr/share/doc/${PF}

	if use doc ; then
		dohtml manual/*
		doins *.pdf
	fi
	if use examples ; then
		doins -r examples
	fi
	if use emacs ; then
		insinto /usr/share/emacs/site-lisp
		doins ipython.el
	fi
}
