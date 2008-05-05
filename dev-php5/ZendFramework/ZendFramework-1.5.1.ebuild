# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/ZendFramework/ZendFramework-1.5.1.ebuild,v 1.2 2008/05/05 20:32:40 maekke Exp $

PHP_LIB_NAME="Zend"

inherit php-lib-r1

KEYWORDS="amd64 x86"

DESCRIPTION="Zend Framework is a high quality and open source framework for developing Web Applications."
HOMEPAGE="http://framework.zend.com/"
SRC_URI="http://framework.zend.com/releases/${P}/${P}.tar.gz
		doc? (
			http://framework.zend.com/releases/${P}/${P}-apidoc.tar.gz
			http://framework.zend.com/releases/${P}/${P}-manual-en.tar.gz )"
LICENSE="BSD"
SLOT="0"
IUSE="doc examples"

DEPEND=""
RDEPEND=""
need_php_by_category

src_install() {
	php-lib-r1_src_install library/Zend $(cd library/Zend ; find . -type f -print)

	if use examples ; then
		insinto /usr/share/doc/${PF}
		doins -r demos
	fi

	dodoc README.txt
	if use doc ; then
		dohtml -r documentation/*
	fi
}

pkg_postinst() {
	elog "For more info, please take a look at the manual at:"
	elog "http://framework.zend.com/manual"
}
