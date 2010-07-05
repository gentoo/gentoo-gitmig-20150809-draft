# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-idn/pecl-idn-0.2.0.ebuild,v 1.1 2010/07/05 11:08:33 mabi Exp $

PHP_EXT_NAME="idn"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="README ChangeLog"

inherit php-ext-pecl-r1

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Binding to the GNU libidn for using Internationalized Domain Names."
LICENSE="PHP-3"
SLOT="0"
IUSE=""

DEPEND="net-dns/libidn"
RDEPEND="${DEPEND}"

need_php_by_category
