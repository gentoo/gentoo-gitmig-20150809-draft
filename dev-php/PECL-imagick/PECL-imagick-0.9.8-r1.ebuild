# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PECL-imagick/PECL-imagick-0.9.8-r1.ebuild,v 1.1 2003/10/21 15:12:47 coredumb Exp $

PHP_EXT_ZENDEXT="no"
PHP_EXT_INI="yes"

inherit php-ext-pecl

IUSE=""
DESCRIPTION="PHP wrapper for the ImageMagick library."
HOMEPAGE="http://pecl.php.net/imagick"
SLOT="0"
LICENSE="PHP"
KEYWORDS="~x86 ~ppc ~alpha ~sparc"

DEPEND=">=media-gfx/imagemagick-5.4.5"

src_install() {
	php-ext-pecl_src_install
	dodoc INSTALL
}
