# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-uuid/pecl-uuid-1.0.2.ebuild,v 1.1 2011/01/05 17:00:36 dev-zero Exp $

EAPI=3

PHP_EXT_NAME="uuid"
PHP_EXT_INIT="yes"
PHP_EXT_ZENDEXT="no"
DOCS="CREDITS"

inherit php-ext-pecl-r2

DESCRIPTION="A wrapper around libuuid."
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="sys-apps/util-linux"
RDEPEND="${DEPEND}"
