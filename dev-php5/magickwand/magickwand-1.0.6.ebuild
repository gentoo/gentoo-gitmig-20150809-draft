# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/magickwand/magickwand-1.0.6.ebuild,v 1.1 2008/02/11 21:22:27 armin76 Exp $

PHP_EXT_NAME="magickwand"
PHP_EXT_ZENDEXT="no"
PHP_EXT_INI="yes"

MY_PN="MagickWandForPHP"

inherit php-ext-source-r1

DESCRIPTION="A native PHP-extension to the ImageMagick MagickWand API."
HOMEPAGE="http://www.magickwand.org/"
SRC_URI="http://www.magickwand.org/download/php/${MY_PN}-${PV}.tar.bz2"

LICENSE="MagickWand"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=">=media-gfx/imagemagick-6.3.5.9"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}"

need_php_by_category

src_install() {
	php-ext-source-r1_src_install

	dodoc-php AUTHOR ChangeLog CREDITS README TODO
}
