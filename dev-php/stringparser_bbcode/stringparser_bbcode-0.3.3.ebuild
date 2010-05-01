# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/stringparser_bbcode/stringparser_bbcode-0.3.3.ebuild,v 1.1 2010/05/01 19:07:50 mabi Exp $

EAPI="2"

inherit php-lib-r1

DESCRIPTION="A PHP class to parse BB codes."
HOMEPAGE="http://christian-seiler.de/projekte/php/bbcode/index_en.html"
SRC_URI="http://christian-seiler.de/projekte/php/bbcode/download/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="|| ( <dev-lang/php-5.3[pcre] >=dev-lang/php-5.3 )"

src_install() {
	php-lib-r1_src_install ./src `find ./src -name '*.php' -print | sed -e "s|./src||g"`
	dodoc-php AUTHORS ChangeLog THANKS
	if use doc ; then
		insinto /usr/share/doc/${CATEGORY}/${PF}/html
		doins -r doc/*
	fi
}
