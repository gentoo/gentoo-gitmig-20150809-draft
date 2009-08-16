# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/c-wrapper/c-wrapper-0.6.1.ebuild,v 1.1 2009/08/16 07:12:45 hattya Exp $

IUSE="examples"

DESCRIPTION="Foreign function interface for C and Objective-C libraries"
HOMEPAGE="http://homepage.mac.com/naoki.koguro/prog/c-wrapper/"
SRC_URI="http://homepage.mac.com/naoki.koguro/prog/${PN}/${P}.tgz"

LICENSE="MIT"
KEYWORDS="~x86"
SLOT="0"

DEPEND=">=dev-scheme/gauche-0.8.14"
RDEPEND="${DEPEND}"

src_compile() {

	econf || die
	emake -j1 || die

}

src_test() {

	emake -j1 -s check || die

}

src_install() {

	emake DESTDIR="${D}" install || die

	dodoc README ChangeLog
	dohtml doc/*

	if use examples; then
		local d

		for d in examples/*; do
			docinto ${d}
			dodoc ${d}/*
		done
	fi

}
