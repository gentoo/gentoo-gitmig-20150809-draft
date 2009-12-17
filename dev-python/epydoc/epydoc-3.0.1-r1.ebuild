# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/epydoc/epydoc-3.0.1-r1.ebuild,v 1.1 2009/12/17 17:03:43 grozin Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Tool for generating API documentation for Python modules, based on their docstrings"
HOMEPAGE="http://epydoc.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="doc latex X"

DEPEND=""
RDEPEND="dev-python/docutils
	latex? ( virtual/latex-base
		|| ( dev-texlive/texlive-latexextra app-text/ptex )
	)
	X? ( dev-lang/python[tk] )"
RESTRICT_PYTHON_ABIS="3.*"

src_prepare() {
	# bug #287546, thanks to Engelbert Gruber <grubert@users.sourceforge.net>
	# and Martin von Gagern <Martin.vGagern@gmx.net>
	epatch "${FILESDIR}"/${PN}-docutils-0.6.patch

	# bug #288273, thanks to Andre Malo <nd@perlig.de>
	epatch "${FILESDIR}"/${PN}-python-2.6.patch
}

src_install() {
	[[ -z ${ED} ]] && local ED=${D}
	distutils_src_install

	doman man/*
	use doc && dohtml -r doc/*
	use X || rm -f "${ED}usr/bin/epydocgui"
}
