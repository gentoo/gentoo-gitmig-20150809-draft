# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-HTML_Select_Common/PEAR-HTML_Select_Common-1.1.ebuild,v 1.4 2003/09/11 17:05:12 robbat2 Exp $

IUSE=""
MY_P=${PN/PEAR-//}-${PV}
DESCRIPTION="Some small classes to handle common <select> lists"
HOMEPAGE="http://pear.php.net/package-info.php?pacid=165"
SRC_URI="http://pear.php.net/get/${MY_P}.tgz"
LICENSE="PHP"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha"
DEPEND="virtual/php"
RDEPEND="${DEPEND}"
S=${WORKDIR}/${MY_P}

src_install () {
	insinto /usr/lib/php/HTML/Select/Common
	doins Select/Common/Country.php
	doins Select/Common/FRDepartements.php
	doins Select/Common/UKCounty.php
	doins Select/Common/USState.php
	insinto /usr/lib/php/Select/Common/examples

	insinto /usr/lib/php/HTML/Select/Common/examples
	doins Select/Common/examples/Country.php
	doins Select/Common/examples/FRDepartements.php
	doins Select/Common/examples/UKCounty.php
	doins Select/Common/examples/USState.php
}
