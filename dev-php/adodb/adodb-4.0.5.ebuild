# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/adodb/adodb-4.0.5.ebuild,v 1.1 2004/01/05 04:59:13 robbat2 Exp $

inherit php-lib

DESCRIPTION="Active Data Objects Data Base library for PHP"
HOMEPAGE="http://php.weblogs.com/ADODB"
MY_P=${PN}${PV//./}
SRC_URI="http://phplens.com/lens/dl/${MY_P}.tgz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
USE=""
DEPEND=""
RDEPEND=">=virtual/php-4.0.5"
S="${WORKDIR}/${PN}"
S2="${WORKDIR}/adodb-xmlschema"

pkg_setup() {
	ewarn "ADODB requires some form of SQL or ODBC support in your PHP."
}

src_unpack() {
	unpack ${A}
	mkdir -p ${S2}
	cd ${S2}
	unzip -qo ${S}/adodb-xmlschema.zip
}

src_install() {
	# install php files
	php-lib_src_install . `find . -name '*.php'`

	# install documentation
	dohtml *.htm
	dodoc *.txt

	# do adodb-xmlschema
	cd ${S2}
	php-lib_src_install . adodb-xmlschema.inc.php

	# do adodb-xmlschema documentation
	docinto xmlschema
	dodoc Changelog LICENSE README INSTALL example* xmlschema.dtd *html
	cp -ra docs ${D}usr/share/doc/${PF}/${DOCDESTTREE}
	prepalldocs
}
