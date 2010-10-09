# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-gearman/pecl-gearman-0.7.0-r1.ebuild,v 1.2 2010/10/09 01:36:16 mr_bones_ Exp $

EAPI=2
PHP_EXT_NAME="gearman"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r2

KEYWORDS="~amd64 ~x86"

DESCRIPTION="PHP extension for using gearmand."
LICENSE="PHP-3"
SLOT="0"
IUSE=""

DEPEND="sys-cluster/gearmand"
RDEPEND="${DEPEND}"
