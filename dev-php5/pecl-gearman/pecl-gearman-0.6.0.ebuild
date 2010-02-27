# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-gearman/pecl-gearman-0.6.0.ebuild,v 1.2 2010/02/27 12:16:55 scarabeus Exp $

PHP_EXT_NAME="gearman"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

KEYWORDS="~amd64"

DESCRIPTION="PHP extension for using gearmand."
LICENSE="PHP-3"
SLOT="0"
IUSE=""

DEPEND="<sys-cluster/gearmand-0.12"
RDEPEND="${DEPEND}"

need_php_by_category
