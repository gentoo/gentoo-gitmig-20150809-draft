# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-HTML_Template_Sigma/PEAR-HTML_Template_Sigma-1.0.ebuild,v 1.1 2003/05/07 20:51:26 method Exp $

P=${PN/PEAR-//}-${PV}
DESCRIPTION="An implementation of Integrated Templates API with template 'compilation' added"
HOMEPAGE="http://pear.php.net/package-info.php?pacid=111"
SRC_URI="http://pear.php.net/get/${P}.tgz"
LICENSE="PHP"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
DEPEND="virtual/php"
RDEPEND="${DEPEND}"
S=${WORKDIR}/${P}

src_install () {
	insinto /usr/lib/php/HTML/Template
	doins Sigma.php
	dodoc docs/*
}
