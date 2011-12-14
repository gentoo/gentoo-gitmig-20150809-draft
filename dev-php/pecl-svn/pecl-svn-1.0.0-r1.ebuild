# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-svn/pecl-svn-1.0.0-r1.ebuild,v 1.1 2011/12/14 22:47:24 mabi Exp $

EAPI=3

PHP_EXT_NAME="svn"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r2

KEYWORDS="~amd64 ~x86"

DESCRIPTION="PHP Bindings for the Subversion Revision control system."
LICENSE="PHP-3.01"
SLOT="0"
IUSE=""

DEPEND="dev-vcs/subversion"
RDEPEND=""
