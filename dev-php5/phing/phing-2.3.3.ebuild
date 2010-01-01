# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/phing/phing-2.3.3.ebuild,v 1.1 2010/01/01 22:30:47 yngwin Exp $

inherit php-pear-lib-r1 eutils

DESCRIPTION="PHP project build system based on Apache Ant"
HOMEPAGE="http://www.phing.info/"
SRC_URI="http://pear.phing.info/get/phing-${PV/_/}.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="minimal"

DEPEND=""
RDEPEND="!minimal? ( >=dev-php/PEAR-PhpDocumentor-1.4.0
	>=dev-php/PEAR-PEAR_PackageFileManager-1.5.2
	>=dev-php/PEAR-VersionControl_SVN-0.3.0_alpha1
	>=dev-php5/phpunit-3.2.0
	>=dev-php5/xdebug-2.0.0
	>=dev-php/simpletest-1.0.1_beta2
	>=dev-php5/creole-1.1.0
	>=dev-lang/php-5.0.2 )"

need_php_by_category

S=${WORKDIR}/${PN}-${PV/_/}

pkg_setup() {
	has_php
	require_php_with_use cli spl reflection xml xsl
}
