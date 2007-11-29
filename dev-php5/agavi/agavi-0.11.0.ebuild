# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/agavi/agavi-0.11.0.ebuild,v 1.1 2007/11/29 23:43:43 jokey Exp $

inherit php-pear-lib-r1 depend.php

KEYWORDS="~amd64 ~x86"

DESCRIPTION="PHP5 MVC Application Framework."
HOMEPAGE="http://www.agavi.org/"
SRC_URI="http://agavi.org/downloads/releases/${PV}.tgz"
LICENSE="LGPL-2.1 as-is public-domain CCPL-Attribution-ShareAlike-2.5"
SLOT="0"
IUSE="minimal"

DEPEND=">=dev-php/PEAR-PEAR-1.6.2-r1
	>=dev-php5/phing-2.2.0
	dev-php/PEAR-PhpDocumentor"
RDEPEND=">=dev-php5/phing-2.2.0
	!minimal? ( dev-php5/creole
		    dev-php5/propel )"

need_php_by_category

pkg_setup() {
	local flags="pcre reflection spl xml"
	use minimal || flags="${flags} iconv nls pdo session tokenizer xmlrpc xsl"
	require_php_with_use ${flags}
}

src_compile() {
	phing -f "${WORKDIR}"/${PV}/build.xml package-pear || die "failed to build pear package"
}

src_install() {
	cd "${WORKDIR}"/${PV}
	cp -pPR build/ "${WORKDIR}"/${P} || die "failed to copy pear package"
	cp build/package.xml "${WORKDIR}" || die "failed to copy package.xml"
	cd "${S}"
	php-pear-lib-r1_src_install
}
