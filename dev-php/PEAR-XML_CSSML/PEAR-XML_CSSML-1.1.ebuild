# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Authore: Tom von Schwerdtner <tvon@etria.org>
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-XML_CSSML/PEAR-XML_CSSML-1.1.ebuild,v 1.1 2002/07/16 09:13:51 rphillips Exp $

P=${PN/PEAR-//}-${PV}
DESCRIPTION="A template system for generating cascading style sheets (CSS)"
HOMEPAGE="http://pear.php.net/package-info.php?pacid=61"
SRC_URI="http://pear.php.net/get/${P}.tgz"
LICENSE="PHP"
SLOT="0"
# Afaik, anything that runs php will run this...
KEYWORDS="x86 ppc sparc"
DEPEND="virtual/php"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}

src_install () {
	insinto /usr/lib/php/XML
	doins CSSML.php
	insinto /usr/lib/php/XML/CSSML/
	doins CSSML/*
}
