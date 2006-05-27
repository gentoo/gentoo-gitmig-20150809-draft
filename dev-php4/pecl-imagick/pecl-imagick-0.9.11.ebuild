# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php4/pecl-imagick/pecl-imagick-0.9.11.ebuild,v 1.6 2006/05/27 00:55:54 chtekk Exp $

PHP_EXT_NAME="imagick"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
DESCRIPTION="PHP wrapper for the ImageMagick library."
LICENSE="PHP"
SLOT="0"
IUSE="graphicsmagick"

DEPEND="${DEPEND}
		!graphicsmagick? ( >=media-gfx/imagemagick-6.2.0 )
		graphicsmagick? ( >=media-gfx/graphicsmagick-1.0.0 )"

need_php_by_category

src_compile() {
	has_php

	my_conf="--with-imagick"
	use graphicsmagick && my_conf="${my_conf} --with-imagick-gm"
	php-ext-pecl-r1_src_compile
}

src_install() {
	php-ext-pecl-r1_src_install
	dodoc-php CREDITS INSTALL
}
