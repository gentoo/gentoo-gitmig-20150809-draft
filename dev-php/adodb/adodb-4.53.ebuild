# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/adodb/adodb-4.53.ebuild,v 1.2 2004/10/30 13:56:57 pfeifer Exp $

inherit php-lib

DESCRIPTION="Active Data Objects Data Base library for PHP"
HOMEPAGE="http://adodb.sourceforge.net/"
MY_P=${PN}${PV//./}
SRC_URI="mirror://sourceforge/adodb/${MY_P}.tgz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~ia64 ~alpha ~sparc ~ppc"
IUSE=""
DEPEND=""
RDEPEND="virtual/php"
S="${WORKDIR}/${PN}"

pkg_setup() {
	ewarn "ADODB requires some form of SQL or ODBC support in your PHP."
}

src_install() {
	# install php files
	php-lib_src_install . `find . -name '*.php'`

	# install xsl files
	insinto /usr/lib/php/adodb/xsl
	doins xsl/*.xsl

	# install documentation
	dohtml docs/*.htm
	dodoc *.txt xmlschema.dtd session/adodb-sess.txt pear/readme.Auth.txt
}
