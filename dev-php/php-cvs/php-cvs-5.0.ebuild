# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/php-cvs/php-cvs-5.0.ebuild,v 1.1 2003/04/25 18:02:10 coredumb Exp $

ECVS_SERVER="cvs.php.net:/repository"
ECVS_MODULE="php5"
ECVS_USER="cvsread"
ECVS_PASS="phpfi"
ECVS_AUTH="pserver"
ECVS_BRANCH=""

inherit php cvs

MY_P=php-${PV}
S=${WORKDIR}/${ECVS_MODULE}
DESCRIPTION="PHP Shell Interpreter - development version"
SRC_URI=""
HOMEPAGE="http://www.php.net/"
LICENSE="PHP"
SLOT="0"
PROVIDE="virtual/php"
KEYWORDS="~x86 ~ppc ~sparc"

src_unpack() {
	cvs_src_unpack
	cd ${S}
}

src_compile() {
	./buildconf
	
	if [ "`use mysql`" ] ; then
		if [ "`mysql_config | grep '4.1'`" ] ; then
			myconf="${myconf} --with-mysqli=/usr"
		else
			myconf="${myconf} --with-mysql=/usr"
		fi
	else
		myconf="${myconf} --without-mysql"
	fi

	myconf="${myconf} --enable-embed"
	myconf="${myconf} --disable-cgi --enable-cli"

	php_src_compile
}


src_install() {
	php_src_install

	docinto Zend
	dodoc Zend/ZEND_CHANGES Zend/ChangeLog Zend/OBJECTS2_HOWTO
}

pkg_postinst() {
	# This fixes the permission from world writeable to the correct one.
	# - novell@kiruna.se
	chmod 755 /usr/bin/pear

	# This is more correct information.
	einfo 
	einfo "This is a CLI only build."
	einfo "You can not use it on a webserver."
	einfo 
}
