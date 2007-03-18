# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/ZendFramework/ZendFramework-0.9.0.ebuild,v 1.1 2007/03/18 14:52:16 chtekk Exp $

PHP_LIB_NAME="Zend"

inherit php-lib-r1

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Zend Framework is a high quality and open source framework for developing Web Applications and Web Services with PHP 5."
HOMEPAGE="http://framework.zend.com/"
SRC_URI="http://framework.zend.com/releases/${P}-Beta.tar.gz"
LICENSE="ZendFramework-1.1"
SLOT="0"
IUSE="doc examples"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${P}-Beta"

need_php_by_category

src_install() {
	php-lib-r1_src_install library/Zend `cd library/Zend ; find . -type f -print`
	php-lib-r1_src_install incubator/library/Zend `cd incubator/library/Zend ; find . -type f -print`

	insinto /usr/share/${PHP_SHARED_CAT}
	doins library/Zend.php

	if use examples ; then
		insinto /usr/share/doc/${P}
		doins -r demos
	fi

	if use doc ; then
		insinto /usr/share/doc/${P}
		dodoc *.txt
		dohtml -r documentation/*
	fi
}
