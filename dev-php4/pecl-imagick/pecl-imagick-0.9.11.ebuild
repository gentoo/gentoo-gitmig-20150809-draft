# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php4/pecl-imagick/pecl-imagick-0.9.11.ebuild,v 1.7 2007/03/06 19:59:59 chtekk Exp $

PHP_EXT_NAME="imagick"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"

DESCRIPTION="PHP wrapper for the ImageMagick library."
LICENSE="PHP"
SLOT="0"
IUSE="graphicsmagick"

DEPEND="!graphicsmagick? ( >=media-gfx/imagemagick-6.2.0 )
		graphicsmagick? ( >=media-gfx/graphicsmagick-1.0.0 )"
RDEPEND="${DEPEND}"

need_php_by_category

src_compile() {
	my_conf="--with-imagick"
	use graphicsmagick && my_conf="${my_conf} --with-imagick-gm"
	php-ext-pecl-r1_src_compile
}

src_install() {
	php-ext-pecl-r1_src_install
	dodoc-php CREDITS INSTALL
}
