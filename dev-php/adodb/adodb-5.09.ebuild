# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/adodb/adodb-5.09.ebuild,v 1.1 2009/06/26 09:04:22 pva Exp $

EAPI="2"

inherit php-lib-r1 versionator

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
DESCRIPTION="Active Data Objects Data Base library for PHP."
HOMEPAGE="http://adodb.sourceforge.net/"

MY_PV=$(delete_all_version_separators "${PV}" )
SRC_URI="mirror://sourceforge/adodb/${PN}${MY_PV}.tgz"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

S=${WORKDIR}/${PN}$(get_major_version)

need_php5

pkg_setup() {
	ewarn "ADODB requires some form of SQL or ODBC support in your PHP."
}

src_prepare() {
	# Check http://phplens.com/lens/lensforum/msgs.php?id=18043
	# probably this mv is a problem...
	mv "${S}"/drivers/adodb-ads{\ ,.}inc.php
}

src_install() {
	# install php files
	php-lib-r1_src_install . $(find . -name '*.php' -print)

	# install xsl files
	php-lib-r1_src_install . xsl/*.xsl

	# install documentation
	dodoc-php *.txt xmlschema.dtd session/adodb-sess.txt pear/readme.Auth.txt
	dohtml-php docs/*.htm
}
