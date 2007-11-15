# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/phing/phing-2.3.0.ebuild,v 1.1 2007/11/15 19:18:14 jokey Exp $

inherit php-pear-lib-r1 eutils

KEYWORDS="~amd64 ~x86"

DESCRIPTION="PHP project build system based on Apache Ant."
HOMEPAGE="http://www.phing.info/"
SRC_URI="http://pear.phing.info/get/phing-${PV/_/}.tgz"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE="minimal"

DEPEND=""
RDEPEND="!minimal? ( >=dev-php/PEAR-PhpDocumentor-1.3.0_rc3
			>=dev-php/PEAR-PEAR_PackageFileManager-1.5.2
			>=dev-php/PEAR-VersionControl_SVN-0.3.0_alpha1
			>=dev-php5/phpunit-2.3.0
			>=dev-php5/xdebug-2.0.0 )"

need_php_by_category

S=${WORKDIR}/${PN}-${PV/_/}

pkg_setup() {
	has_php
	require_php_with_use cli spl reflection xml xsl
}
