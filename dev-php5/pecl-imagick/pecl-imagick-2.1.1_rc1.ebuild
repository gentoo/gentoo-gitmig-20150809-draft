# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-imagick/pecl-imagick-2.1.1_rc1.ebuild,v 1.1 2008/03/03 17:02:27 jokey Exp $

PHP_EXT_NAME="imagick"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="TODO"

inherit php-ext-pecl-r1

KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"

DESCRIPTION="PHP wrapper for the ImageMagick library."
LICENSE="PHP-3.01"
SLOT="0"
IUSE="examples"

DEPEND=">=media-gfx/imagemagick-6.2.4"
RDEPEND="${DEPEND}"

need_php_by_category
my_conf="--with-imagick=/usr"

src_unpack() {
	# this can go away in 2.1.1
	unpack ${A}
	cd "${WORKDIR}"
	mv ${PECL_PKG_V/rc/RC} ${PECL_PKG_V}
}
