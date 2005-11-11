# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/onphp/onphp-0.2.1.ebuild,v 1.1 2005/11/11 01:09:58 voxus Exp $

DESCRIPTION="onPHP is the GPL'ed multi-purpose object-oriented PHP framework."
HOMEPAGE="http://onphp.shadanakar.org/"
SRC_URI="http://onphp.shadanakar.org/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND=">=virtual/php-5.0.0"

TARGETDIR="${D}/usr/share/php/${PN}"

src_install() {
	use doc && {
		find doc -maxdepth 1 -type f -exec dodoc {} \;
	}

	mkdir -p ${TARGETDIR}

	cp -pPR core main ${TARGETDIR}/
	cp global.inc.php.tpl ${TARGETDIR}/global.inc.php
}
