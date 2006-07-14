# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/queequeg/queequeg-0.91.ebuild,v 1.6 2006/07/14 13:18:39 hattya Exp $

inherit distutils multilib

IUSE=""

DESCRIPTION="A checker for English grammars, for people who are not English natives."
HOMEPAGE="http://queequeg.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

RESTRICT="nomirror"
LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"

DEPEND=">=dev-lang/python-2.3
	app-dicts/wordnet"

src_compile() {

	local dictdir=/usr/dict

	if has_version =app-dicts/wordnet-2.0; then
		dictdir=/usr/share/wordnet/dict
	fi

	emake dict WORDNETDICT=${dictdir} || die

}

src_install() {

	python_version
	local prefix=/usr/$(get_libdir)/python${PYVER}/site-packages/${PN}

	insinto ${prefix}
	doins *.py
	[ -f "dict.txt" ] && doins dict.txt || doins dict.cdb

	exeinto ${prefix}
	doexe qq
	dosym ${prefix}/qq /usr/bin/qq

	dodoc README TODO
	dohtml htdocs/*

}
