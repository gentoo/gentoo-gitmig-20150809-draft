# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-imagick/pecl-imagick-0.9.11.ebuild,v 1.2 2005/09/08 00:06:13 swegener Exp $

PHP_EXT_ZENDEXT="no"
PHP_EXT_INI="yes"

inherit php-ext-pecl-r1

IUSE="graphicsmagick"
DESCRIPTION="PHP wrapper for the ImageMagick library."
HOMEPAGE="http://pecl.php.net/imagick"
SLOT="0"
LICENSE="PHP"
KEYWORDS="~ppc ~x86"

DEPEND="!graphicsmagick? ( >=media-gfx/imagemagick-6.2.0 )
	graphicsmagick? ( >=media-gfx/graphicsmagick-1.0.0 )"

need_php_by_category

src_compile () {
	my_conf="--with-imagick"
	use graphicsmagick && my_conf="${my_conf} --with-imagick-gm"
	php-ext-pecl-r1_src_compile
}

src_install() {
	php-ext-pecl-r1_src_install
	dodoc CREDITS INSTALL
}
