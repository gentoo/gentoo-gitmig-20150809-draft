# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/stringparser_bbcode/stringparser_bbcode-0.3.2a.ebuild,v 1.1 2007/12/15 12:10:46 jokey Exp $

inherit php-lib-r1

DESCRIPTION="A PHP class to parse BB codes."
HOMEPAGE="http://christian-seiler.de/projekte/php/bbcode/index_en.html"
SRC_URI="http://christian-seiler.de/projekte/php/bbcode/download/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

pkg_setup() {
	require_php_with_use pcre
}

src_install() {
	php-lib-r1_src_install ./src `find ./src -name '*.php' -print | sed -e "s|./src||g"`
	dodoc-php AUTHORS ChangeLog THANKS
	use doc && dohtml -r doc/*
}
