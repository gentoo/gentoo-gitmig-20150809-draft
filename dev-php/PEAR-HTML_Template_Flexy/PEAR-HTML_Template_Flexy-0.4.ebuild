# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-HTML_Template_Flexy/PEAR-HTML_Template_Flexy-0.4.ebuild,v 1.6 2004/01/24 16:39:20 coredumb Exp $

MY_P=${PN/PEAR-//}-${PV}
DESCRIPTION="An extremely powerful Tokenizer driven Template engine"
HOMEPAGE="http://pear.php.net/package-info.php?pacid=111"
SRC_URI="http://pear.php.net/get/${MY_P}.tgz"
LICENSE="PHP"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha"
DEPEND="virtual/php"
RDEPEND="${DEPEND}"
S=${WORKDIR}/${MY_P}

src_install () {
	insinto /usr/lib/php/HTML/Template
	doins Flexy.php
	insinto /usr/lib/php/HTML/Template/Flexy/
	doins Flexy/*
}
