# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/php/php-5.0.2-r1.ebuild,v 1.3 2004/11/21 06:45:39 kingtaco Exp $

PHPSAPI="cli"
MY_P="${PN}-${PV}"
inherit php5-sapi eutils

DESCRIPTION="PHP Shell Interpreter"
LICENSE="PHP"
KEYWORDS="~arm ~hppa ~ia64 ~ppc ~x86 ~ppc64 ~amd64"
DEPEND="$DEPEND"
RDEPEND="$RDEPEND"
PROVIDE="virtual/php-${PV}"
SLOT="0"

# PHP_INSTALLTARGETS="${PHP_INSTALLTARGETS} install-cli"

src_compile () {
	my_conf="--disable-cgi --enable-cli --enable-embed"

	php5-sapi_src_compile
}
