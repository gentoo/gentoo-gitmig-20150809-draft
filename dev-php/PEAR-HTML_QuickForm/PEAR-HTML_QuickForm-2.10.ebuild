# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-HTML_QuickForm/PEAR-HTML_QuickForm-2.10.ebuild,v 1.5 2003/05/07 19:09:07 method Exp $

P=${PN/PEAR-//}-${PV}
DESCRIPTION="The PEAR::HTML_QuickForm package provides methods for creating, validating, processing HTML forms."
HOMEPAGE="http://pear.php.net/package-info.php?pacid=58"
SRC_URI="http://pear.php.net/get/${P}.tgz"
LICENSE="PHP"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
DEPEND="virtual/php
	dev-php/PEAR-HTML_Common"
RDEPEND="${DEPEND}"
S=${WORKDIR}/${P}

src_install () {
	insinto /usr/lib/php/HTML
	doins QuickForm.php
	insinto /usr/lib/php/HTML/QuickForm/
	doins QuickForm/*
	dodoc docs/*
}
