# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Mail_Mime/PEAR-Mail_Mime-1.2.1.ebuild,v 1.8 2003/09/11 17:04:04 robbat2 Exp $

MY_P=${PN/PEAR-//}-${PV}
DESCRIPTION="Provides classes to deal with creation and manipulation of mime messages."
HOMEPAGE="http://pear.php.net/package-info.php?pacid=21"
SRC_URI="http://pear.php.net/get/${MY_P}.tgz"
LICENSE="PHP"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha"
DEPEND="virtual/php"
RDEPEND="${DEPEND}"
S=${WORKDIR}/${MY_P}

src_install () {
	insinto /usr/lib/php/Mail
	doins mime.php
	doins mimeDecode.php
	doins mimePart.php
	doins xmail.dtd
	doins xmail.xsl
}


