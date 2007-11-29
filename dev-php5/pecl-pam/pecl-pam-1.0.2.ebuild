# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-pam/pecl-pam-1.0.2.ebuild,v 1.1 2007/11/29 23:52:21 jokey Exp $

PHP_EXT_NAME="pam"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="README"

inherit php-ext-pecl-r1 pam

KEYWORDS="~x86"

DESCRIPTION="This extension provides PAM (Pluggable Authentication Modules) integration."
LICENSE="PHP"
SLOT="0"
IUSE="debug"

DEPEND="sys-libs/pam"
RDEPEND="${DEPEND}"

need_php_by_category

src_compile() {
	my_conf="--with-pam=/usr $(use_enable debug)"
	php-ext-pecl-r1_src_compile
}

src_install() {
	pamd_mimic_system php auth account password
	php-ext-pecl-r1_src_install
}
