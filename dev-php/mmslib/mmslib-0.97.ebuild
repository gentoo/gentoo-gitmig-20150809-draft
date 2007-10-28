# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/mmslib/mmslib-0.97.ebuild,v 1.1 2007/10/28 11:32:42 jokey Exp $

inherit php-lib-r1

DESCRIPTION="library for encoding, decoding, and sending MMSes"
HOMEPAGE="http://www.hellkvist.org/software/#MMSLIB"
SRC_URI="http://www.hellkvist.org/software/mmslib/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

DEPEND=""
RDEPEND=""

need_php_by_category

src_install() {
	php-lib-r1_src_install ./ mmslib.php
	dodoc-php README

	if use examples; then
		insinto /usr/share/doc/${CATEGORY}/${PF}
		doins -r samples
		doins -r content
	fi
}

pkg_postinst() {
	elog
	elog "${PHP_LIB_NAME} has been installed in /usr/share/${CATEGORY}/${PHP_LIB_NAME}."
	use examples && elog "Examples can be found in /usr/share/doc/${CATEGORY}/${PF}"
	elog
}
