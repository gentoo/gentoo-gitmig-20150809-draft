# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/php/php-5.0.0-r1.ebuild,v 1.2 2004/08/09 09:50:57 robbat2 Exp $

PHPSAPI="cli"
MY_P="${PN}-${PV}"
inherit php5-sapi eutils

DESCRIPTION="PHP Shell Interpreter"
LICENSE="PHP"
KEYWORDS="-x86"
DEPEND="$DEPEND"
RDEPEND="$RDEPEND"
SLOT="0"

# PHP_INSTALLTARGETS="${PHP_INSTALLTARGETS} install-cli"

src_compile () {
	my_conf="--disable-cgi --enable-cli --enable-embed"

	php5-sapi_src_compile
}
