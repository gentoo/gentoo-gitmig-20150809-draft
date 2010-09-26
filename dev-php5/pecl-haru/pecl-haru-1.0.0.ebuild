# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-haru/pecl-haru-1.0.0.ebuild,v 1.1 2010/09/26 18:22:35 olemarkus Exp $

EAPI=3

PHP_EXT_NAME="haru"

inherit php-ext-pecl-r1

DESCRIPTION="An interface to libharu, a PDF generator"

LICENSE="PHP-3.01"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="png zlib"

DEPEND="media-libs/libharu[png?,zlib?]"
RDEPEND="${DEPEND}"

need_php_by_category

src_configure() {
	true # php-ext-*-r1 doesn't really support EAPI=3
}

src_compile() {
	# config.m4 is broken checking paths, so we need to override it
	my_conf="--with-haru=/usr"
	use png && my_conf+=" --with-png-dir=/usr"
	use zlib && my_conf+=" --with-zlib-dir=/usr"

	php-ext-source-r1_src_compile
}
