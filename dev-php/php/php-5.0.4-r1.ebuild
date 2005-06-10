# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/php/php-5.0.4-r1.ebuild,v 1.3 2005/06/10 23:45:29 stuart Exp $

PHPSAPI="cli"
MY_PHP_P="php-${PV}"
PHP_S="${WORKDIR}/${MY_PHP_P}"
PHP_PACKAGE=1

inherit php5-sapi-r2 eutils

DESCRIPTION="PHP Shell Interpreter"
LICENSE="PHP"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"
DEPEND="$DEPEND"
RDEPEND="$RDEPEND"
PROVIDE="virtual/php"
SLOT="0"

PHP_INSTALLTARGETS="${PHP_INSTALLTARGETS} install-cli"

src_unpack() {
	php5-sapi-r2_src_unpack

	###########################################################################
	# DO NOT ADD YOUR PATCHES HERE
	#
	# Please add your patches into the eclass, where they belong!
	#
	# Thanks,
	# Stu
	###########################################################################
}

src_compile () {
	my_conf="--disable-cgi --enable-cli"
	php5-sapi-r2_src_compile
}
