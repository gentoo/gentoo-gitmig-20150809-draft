# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/mongo/mongo-1.0.6.ebuild,v 1.2 2010/06/16 16:23:41 ramereth Exp $

EAPI="2"

PHP_EXT_NAME="mongo"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-source-r1
MY_PN="${PN}-php-driver"

DESCRIPTION="Officially supported PHP driver for MongoDB"
HOMEPAGE="http://github.com/mongodb/mongo-php-driver"
SRC_URI="http://github.com/mongodb/${MY_PN}/tarball/${PV} -> ${MY_PN}-${PV}.tar.gz"

S="${WORKDIR}/mongodb-${MY_PN}-a54a5f7"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DOCS="README.rdoc"
my_conf="--enable-mongo"

need_php_by_category

src_install() {
	php-ext-source-r1_src_install
	dodir "${PHP_EXT_SHARED_DIR}"
	insinto "${PHP_EXT_SHARED_DIR}"
	doins -r php/Mongo/*
}
