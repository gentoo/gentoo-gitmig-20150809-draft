# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/queequeg/queequeg-0.91.ebuild,v 1.1 2004/10/17 10:27:37 hattya Exp $

inherit distutils

IUSE=""

DESCRIPTION="A checker for English grammars, for people who are not English natives."
HOMEPAGE="http://queequeg.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

RESTRICT="nomirror"
LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"

DEPEND=">=dev-lang/python-2.2
	app-dicts/wordnet"

src_compile() {

	emake dict WORDNETDICT=/usr/share/wordnet/dict || die

}

src_install() {

	python_version
	local PREFIX=/usr/$(get_libdir)/python${PYVER}/site-packages/${PN}

	dodir /usr/bin ${PREFIX}

	insinto ${PREFIX}
	doins *.py
	[ -f "dict.txt" ] && doins dict.txt || doins dict.cdb

	exeinto ${PREFIX}
	doexe *.py qq

	dosym ${PREFIX}/qq /usr/bin/qq

	dodoc COPYING README TODO
	dohtml htdocs/*

}
