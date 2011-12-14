# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-idn/pecl-idn-0.2.0-r1.ebuild,v 1.1 2011/12/14 22:39:17 mabi Exp $

EAPI=3

PHP_EXT_NAME="idn"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="README ChangeLog"

inherit php-ext-pecl-r2

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Binding to the GNU libidn for using Internationalized Domain Names."
LICENSE="PHP-3"
SLOT="0"
IUSE=""

DEPEND="net-dns/libidn"
RDEPEND="${DEPEND}"
