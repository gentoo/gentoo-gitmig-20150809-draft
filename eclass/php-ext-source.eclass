# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/php-ext-source.eclass,v 1.9 2004/09/05 20:57:19 robbat2 Exp $
#
# Author: Tal Peer <coredumb@gentoo.org>
# Author: Stuart Herbert <stuart@gentoo.org>
#
# The php-ext-source eclass provides a unified interface for compiling and
# installing standalone PHP extensions ('modules') from source code
#
# To use this eclass, you must add the following to your ebuild:
#
# inherit php-ext-source

inherit php-ext-base

ECLASS=php-ext-source
INHERITED="$INHERITED $ECLASS"

EXPORT_FUNCTIONS src_compile src_install

# ---begin ebuild configurable settings

# Wether or not to add a line in the php.ini for the extension
# (defaults to "yes" and shouldn't be changed in most cases)
[ -z "$PHP_EXT_INI" ] && PHP_EXT_INI="yes"

# ---end ebuild configurable settings

DEPEND="${DEPEND}
		dev-php/php
		>=sys-devel/m4-1.4
		>=sys-devel/libtool-1.4.3"

RDEPEND="${RDEPEND}
		virtual/php"

php-ext-source_src_compile() {
	addpredict /usr/share/snmp/mibs/.index
	#phpize creates configure out of config.m4
	phpize
	econf $myconf
	emake || die
}

php-ext-source_src_install() {
	addpredict /usr/share/snmp/mibs/.index
	chmod +x build/shtool
	insinto $EXT_DIR
	doins modules/$PHP_EXT_NAME.so
	php-ext-base_src_install
}
