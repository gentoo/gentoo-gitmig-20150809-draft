# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/yaml/yaml-1.0.5.ebuild,v 1.1 2011/03/26 12:04:20 olemarkus Exp $

EAPI=3

PHP_PEAR_CHANNEL="pear.phpunit.de"
PHP_PEAR_PN="PHPUnit"

inherit php-pear-lib-r1


DESCRIPTION="The Symfony YAML Component."
HOMEPAGE="http://symfony-project.com/"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

