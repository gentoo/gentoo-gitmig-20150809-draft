# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-mogilefs/pecl-mogilefs-0.8.1.ebuild,v 1.1 2011/12/14 22:43:21 mabi Exp $

EAPI="2"
PHP_EXT_NAME="mogilefs"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="README"

USE_PHP="php5-2 php5-3"

inherit php-ext-pecl-r2

KEYWORDS="~amd64 ~x86"

DESCRIPTION="PHP client library to communicate with the MogileFS storage"
# this is the old homepage, but it has documentation which the PECL page
# doesn't...
HOMEPAGE="http://projects.usrportage.de/index.fcgi/php-mogilefs"
LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND="net-libs/neon"
RDEPEND="${DEPEND}"

src_prepare() {
	# config.m4 looks for xml2-config but doesn't actually use it...
	sed -i -e '/Cannot find libxml2/d' \
		"${S}"/config.m4

	php-ext-source-r2_src_prepare
}

src_configure() {
	my_conf="--with-mogilefs"
	php-ext-source-r2_src_configure
}
