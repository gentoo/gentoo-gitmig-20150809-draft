# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/adodb/adodb-4.94.ebuild,v 1.5 2007/08/13 20:32:59 dertobi123 Exp $

inherit php-lib-r1

KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"

DESCRIPTION="Active Data Objects Data Base library for PHP."
HOMEPAGE="http://adodb.sourceforge.net/"
SRC_URI="mirror://sourceforge/adodb/${PN}${PV//./}.tgz"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

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
