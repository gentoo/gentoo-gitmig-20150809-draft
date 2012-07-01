# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/jonpy/jonpy-0.07.ebuild,v 1.5 2012/07/01 18:16:57 armin76 Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Powerful multi-threaded object-oriented CGI/FastCGI/mod_python/html-templating facilities"
HOMEPAGE="http://jonpy.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="doc examples"

DEPEND=""
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

PYTHON_MODNAME="jon"

src_install() {
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r example
	fi

	if use doc; then
		dohtml doc/*
	fi
}
