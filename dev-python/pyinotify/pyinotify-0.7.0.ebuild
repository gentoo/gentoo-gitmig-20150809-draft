# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyinotify/pyinotify-0.7.0.ebuild,v 1.2 2007/09/07 19:15:22 josejx Exp $

NEED_PYTHON="2.3"

inherit distutils

DESCRIPTION="Python wrapper for inotify"
HOMEPAGE="http://pyinotify.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc examples"

src_install() {
	DOCS="AUTHORS NEWS"
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r src/examples
	fi

	if use doc; then
		dohtml -r doc/*
	fi
}
