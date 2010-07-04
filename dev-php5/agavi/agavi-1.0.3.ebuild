# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/agavi/agavi-1.0.3.ebuild,v 1.2 2010/07/04 14:13:05 mabi Exp $

EAPI="2"

inherit php-pear-lib-r1

KEYWORDS="~amd64 ~x86"

DESCRIPTION="PHP5 MVC Application Framework."
HOMEPAGE="http://www.agavi.org/"
SRC_URI="http://d10xg45o6p6dbl.cloudfront.net/projects/a/agavi/${PV}.tgz"
LICENSE="LGPL-2.1 as-is public-domain CCPL-Attribution-ShareAlike-2.5"
SLOT="0"
IUSE=""

# currently fails to install with dev-php/PEAR-PEAR_PackageFileManager-1.7.0
DEPEND="
	>=dev-lang/php-5[xml]
	|| ( <dev-lang/php-5.3[pcre,reflection,spl] >=dev-lang/php-5.3 )
	>=dev-php/PEAR-PEAR-1.6.2-r1
	>=dev-php5/phing-2.2.0[-minimal]
	<dev-php/PEAR-PEAR_PackageFileManager-1.7.0
	"

RDEPEND="
	>=dev-php5/phing-2.2.0
	"

src_compile() {
	cd "${WORKDIR}/${PV}"
	phing package-pear || die "failed to build pear package"
}

src_install() {
	cd "${WORKDIR}"/${PV}
	cp -pPR pear-build/ "${WORKDIR}"/${P} || die "failed to copy pear package"
	cp pear-build/package.xml "${WORKDIR}" || die "failed to copy package.xml"
	cd "${S}"
	php-pear-lib-r1_src_install
}
