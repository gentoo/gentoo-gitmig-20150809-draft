# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/jonpy/jonpy-0.07.ebuild,v 1.1 2009/09/07 19:52:23 patrick Exp $

NEED_PYTHON=2.2

inherit distutils

DESCRIPTION="Powerful multi-threaded object-oriented CGI/FastCGI/mod_python/html-templating facilities"
HOMEPAGE="http://jonpy.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
SLOT="0"
LICENSE="as-is"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE="doc examples"

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
