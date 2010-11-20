# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-imagick/pecl-imagick-3.0.0.ebuild,v 1.2 2010/11/20 13:08:50 hwoarang Exp $

PHP_EXT_NAME="imagick"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="TODO"

inherit php-ext-pecl-r1

KEYWORDS="amd64 ~ppc ~ppc64 ~sparc ~x86"

DESCRIPTION="PHP wrapper for the ImageMagick library."
LICENSE="PHP-3.01"
SLOT="0"
IUSE="examples"

DEPEND=">=media-gfx/imagemagick-6.2.4"
RDEPEND="${DEPEND}"

need_php_by_category

MY_PV="${PV/_/}"
PECL_PKG_V="${PECL_PKG}-${MY_PV}"
FILENAME="${PECL_PKG_V}.tgz"
SRC_URI="http://pecl.php.net/get/${FILENAME}"
S="${WORKDIR}/${PECL_PKG_V}"

my_conf="--with-imagick=/usr"
