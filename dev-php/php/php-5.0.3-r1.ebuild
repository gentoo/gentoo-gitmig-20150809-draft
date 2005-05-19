# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/php/php-5.0.3-r1.ebuild,v 1.2 2005/05/19 20:21:05 robbat2 Exp $

PHPSAPI="cli"
MY_P="${PN}-${PV}"
inherit php5-sapi eutils

DESCRIPTION="PHP Shell Interpreter"
LICENSE="PHP"
KEYWORDS="~arm ~hppa ~ia64 ~ppc ~x86 ~ppc64 ~sparc ~amd64"
DEPEND="$DEPEND"
RDEPEND="$RDEPEND"
PROVIDE="virtual/php"
SLOT="0"

# PHP_INSTALLTARGETS="${PHP_INSTALLTARGETS} install-cli"

src_unpack() {
	php5-sapi_src_unpack
	[ "${ARCH}" == "sparc" ] && epatch ${FILESDIR}/stdint.diff
	epatch ${FILESDIR}/${P}-missing-arches.patch
	epatch ${FILESDIR}/libmbfl-headers.patch
}

src_compile () {
	my_conf="--disable-cgi --enable-cli --enable-embed"

	php5-sapi_src_compile
}
