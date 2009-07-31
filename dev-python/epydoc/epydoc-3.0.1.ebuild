# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/epydoc/epydoc-3.0.1.ebuild,v 1.12 2009/07/31 11:51:45 arfrever Exp $

EAPI="2"

inherit distutils

DESCRIPTION="Tool for generating API documentation for Python modules, based on their docstrings"
HOMEPAGE="http://epydoc.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~m68k ~mips ppc ppc64 ~s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE="doc latex X"

RDEPEND="dev-python/docutils
	latex? ( virtual/latex-base
		|| ( dev-texlive/texlive-latexextra app-text/ptex )
	)
	X? ( dev-lang/python[tk] )"
DEPEND=""

src_install() {
	distutils_src_install

	doman man/*
	use doc && dohtml -r doc/*
	use X || rm -f "${D}usr/bin/epydocgui"
}
