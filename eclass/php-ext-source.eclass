# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/php-ext-source.eclass,v 1.3 2003/07/25 17:44:28 stuart Exp $
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
		virtual/php
		=sys-devel/m4-1.4
		>=sys-devel/libtool-1.4.3"

php-ext-source_src_compile() {
	#phpize creates configure out of config.m4
	phpize
	econf $myconf
	emake || die
}

php-ext-source_src_install() {
	chmod +x build/shtool
	#this will usually be /usr/lib/php/extensions/no-debug-no-zts-20020409/ 
	#but i prefer not taking this risk
	EXT_DIR=`php-config --extension-dir`
	insinto $EXT_DIR
	doins modules/$PHP_EXT_NAME.so
}
