# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/onphp/onphp-0.2.18.ebuild,v 1.3 2007/02/13 20:35:32 mr_bones_ Exp $

inherit php-lib-r1

KEYWORDS="x86 amd64"
DESCRIPTION="onPHP is the GPL'ed multi-purpose object-oriented PHP framework."
HOMEPAGE="http://onphp.org/"
SRC_URI="http://onphp.org/download/${P}.tar.bz2
		doc? ( http://onphp.org/download/${PN}-api-${PV}.tar.bz2 )"
LICENSE="GPL-2"
SLOT="0"
IUSE="doc"

need_php_by_category

src_install() {
	has_php

	if use doc ; then
		for doc in `find doc -maxdepth 1 -type f -print`; do
			dodoc ${doc}
		done

		dohtml -r "${WORKDIR}/${PN}-api-${PV}/"*
	fi

	php-lib-r1_src_install ./ global.inc.php.tpl
	php-lib-r1_src_install ./ `find core -type f -print`
	php-lib-r1_src_install ./ `find main -type f -print`
}
