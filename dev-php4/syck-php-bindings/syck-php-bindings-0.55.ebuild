# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php4/syck-php-bindings/syck-php-bindings-0.55.ebuild,v 1.1 2006/10/04 14:19:14 yuval Exp $

PHP_EXT_NAME="syck"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-source-r1

MY_P="syck-${PV}"
DESCRIPTION="PHP bindings for Syck - an extension for reading and writing YAML swiftly in popular scripting languages."
HOMEPAGE="http://whytheluckystiff.net/syck/"
SRC_URI="http://rubyforge.org/frs/download.php/4492/${MY_P}.tar.gz"
LICENSE="BSD"

SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

DEPEND="~dev-libs/syck-${PV}
	!=dev-libs/syck-0.55-r1"
RDEPEND="${DEPEND}"

need_php_by_category

S=${WORKDIR}/${MY_P}/ext/php

src_compile() {
	has_php
	my_conf="--with-syck"
	php-ext-source-r1_src_compile
}

src_install() {
	php-ext-source-r1_src_install
}
