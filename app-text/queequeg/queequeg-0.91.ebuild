# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/queequeg/queequeg-0.91.ebuild,v 1.7 2007/01/19 14:50:21 masterdriverz Exp $

inherit distutils multilib

IUSE=""

DESCRIPTION="A checker for English grammar, for people who are not native English."
HOMEPAGE="http://queequeg.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

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
