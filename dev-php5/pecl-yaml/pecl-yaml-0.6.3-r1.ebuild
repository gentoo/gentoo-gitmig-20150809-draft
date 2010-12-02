# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-yaml/pecl-yaml-0.6.3-r1.ebuild,v 1.1 2010/12/02 10:22:06 olemarkus Exp $

EAPI="2"

PHP_EXT_NAME="yaml"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="CREDITS EXPERIMENTAL README"

inherit php-ext-pecl-r2

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Support for YAML 1.1 (YAML Ain't Markup Language) serialization
using the LibYAML library."
LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND=">=dev-libs/libyaml-0.1.0"
RDEPEND="${DEPEND}"
