# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/adodb/adodb-4.65-r1.ebuild,v 1.2 2005/09/24 17:25:06 cryos Exp $

inherit php-lib-r1

DESCRIPTION="Active Data Objects Data Base library for PHP"
HOMEPAGE="http://adodb.sourceforge.net/"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

MY_P=${PN}${PV//./}
SRC_URI="mirror://sourceforge/adodb/${MY_P}.tgz"
S="${WORKDIR}/${PN}"

need_php_by_category

pkg_setup() {
	ewarn "ADODB requires some form of SQL or ODBC support in your PHP."
}

src_install() {
	# install php files
	php-lib-r1_src_install . `find . -name '*.php' -print`

	# install xsl files
	php-lib-r1_src_install . xsl/*.xsl

	# install documentation
	dohtml docs/*.htm
	dodoc *.txt xmlschema.dtd session/adodb-sess.txt pear/readme.Auth.txt
}
