# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/php-ext.eclass,v 1.1 2003/05/15 18:45:26 coredumb Exp $
#
# Author: Tal Peer <coredumb@gentoo.org>
#
# The php-ext eclass provides a unified interface for compiling and
# installing standalone PHP extensions ('modules').

ECLASS=php-ext
INHERITED="$INHERITED $ECLASS"

EXPORT_FUNCTIONS src_compile src_install pkg_postinst

# ---begin ebuild configurable settings

# The extension name, this must be set, otherwise we die.
[ -z "$PHP_EXT_NAME" ] && die "No module name specified for the php-ext eclass."

# Whether the extensions is a Zend Engine extension
#(defaults to "no" and if you don't know what is it, you don't need it.)
[ -z "$PHP_EXT_ZENDEXT" ] && PHP_EXT_ZENDEXT="no"

# ---end ebuild configurable settings

DEPEND="${DEPEND}
		virtual/php
		=sys-devel/m4-1.4
		>=sys-devel/libtool-1.4.3"

php-ext_src_compile() {
	#phpize creates configure out of config.m4
	phpize
	econf $myconf
	emake || die
}

php-ext_src_install() {
	chmod +x build/shtool
	#this will usually be /usr/lib/php/extensions/no-debug-no-zts-20020409/ 
	#but i prefer not taking this risk
	EXT_DIR=`php-config --extension-dir`
	insinto $EXT_DIR
	doins modules/$PHP_EXT_NAME.so
}

php-ext_pkg_postinst() {
	if [ `grep ${EXT_DIR}/${PHP_EXT_NAME}.so /etc/php4/php.ini` ] ; then
		einfo "No changes made to php.ini"
	else
		if [ "$PHP_EXT_ZENDEXT" = "yes" ] ; then
			echo zend_extension=${EXT_DIR}/${PHP_EXT_NAME}.so >> /etc/php4/php.ini
		else
			echo extension=${EXT_DIR}/${PHP_EXT_NAME}.so >> /etc/php4/php.ini
		fi
		
		einfo "${PHP_EXT_NAME} has been added to php.ini"
		einfo "Please check phpinfo() output to verify that ${PHP_EXT_NAME} is loaded."
	fi
}
