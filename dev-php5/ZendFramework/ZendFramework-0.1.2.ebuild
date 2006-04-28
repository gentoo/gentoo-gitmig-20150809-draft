# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/ZendFramework/ZendFramework-0.1.2.ebuild,v 1.2 2006/04/28 09:28:15 sebastian Exp $

inherit php-lib-r1

DESCRIPTION="Zend Framework is a high quality and open source framework for developing Web Applications and Web Services with PHP 5."
HOMEPAGE="http://framework.zend.com/"
SRC_URI="http://framework.zend.com/releases/${P}.tar.gz"

LICENSE="ZendFramework-1.0"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

PHP_LIB_NAME="Zend"

need_php_by_category

src_install() {
	php-lib-r1_src_install library/Zend `cd library/Zend ; find . -type f -print`
	php-lib-r1_src_install incubator/Zend `cd incubator/Zend ; find . -type f -print`

	insinto /usr/share/${PHP_SHARED_CAT}
	doins library/Zend.php

	insinto /usr/share/doc/${P}
	doins -r demos

	dodoc *.txt
	dohtml -r documentation/*
}
