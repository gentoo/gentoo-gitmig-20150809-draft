# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/php/php-5.0.0.ebuild,v 1.2 2004/07/14 12:55:07 stuart Exp $

PHPSAPI="cli"
MY_P="${PN}-${PV}"
inherit php5-sapi eutils

DESCRIPTION="PHP Shell Interpreter"
LICENSE="PHP"
SLOT="0"
KEYWORDS="~x86"
DEPEND="$DEPEND"
RDEPEND="$RDEPEND"

# PHP_INSTALLTARGETS="${PHP_INSTALLTARGETS} install-cli"

src_compile () {
	my_conf="--disable-cgi --enable-cli"

	php5-sapi_src_compile
}
