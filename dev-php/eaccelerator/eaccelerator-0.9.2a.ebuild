# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/eaccelerator/eaccelerator-0.9.2a.ebuild,v 1.5 2005/03/19 23:02:35 weeve Exp $

PHP_EXT_NAME="eaccelerator"
PHP_EXT_ZENDEXT="yes"
[ -z "${EACCELERATOR_CACHEDIR}" ] && EACCELERATOR_CACHEDIR=/var/cache/eaccelerator
inherit php-ext-source

DESCRIPTION="A PHP Accelerator & Encoder."
HOMEPAGE="http://www.eaccelerator.net/"
SRC_URI="mirror://sourceforge/eaccelerator/${P}.tar.gz"
S=${WORKDIR}/eaccelerator
IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 sparc"

DEPEND="$DEPEND
		!dev-php/ioncube_loaders
		!dev-php/php-accelerator
		!dev-php/PECL-apc
		!dev-php/turck-mmcache"

src_compile() {
	# eAccelerator does not work with Zend Thread Safety (ZTS)
	# so about if we are using Apache 2 with an MPM that would
	# require ZTS.
	if has_version '>=net-www/apache-2*'; then
		APACHE2_MPM="`/usr/sbin/apache2 -l | egrep 'worker|perchild|leader|threadpool|prefork'|cut -d. -f1|sed -e 's/^[[:space:]]*//g;s/[[:space:]]+/ /g;'`"
		case "${APACHE2_MPM}" in
			*prefork*) ;;
			*) eerror "eAccelerator does not yet work with the Apache 2 MPM in use." ; die ;;
		esac;
	fi

	myconf="--enable-eaccelerator=shared"
	php-ext-source_src_compile
}

src_install() {
	php-ext-source_src_install

	# create cache dir if it does not exist
	#
	# settings should ensure that cached files are secure,
	# *but* this may break php-cli
	#
	# please file a bug in http://bugs.gentoo.org if this happens
	# for you

	keepdir ${EACCELERATOR_CACHEDIR}
	fowners root:root ${EACCELERATOR_CACHEDIR}
	fperms 1777 ${EACCELERATOR_CACHEDIR}

	insinto /usr/share/${PN}
	doins encoder.php eaccelerator.php eaccelerator_password.php
	dodoc AUTHORS ChangeLog COPYING NEWS README README.eLoader

	php-ext-base_addtoinifiles "eaccelerator.shm_size" '"16"'
	php-ext-base_addtoinifiles "eaccelerator.cache_dir" "\"${EACCELERATOR_CACHEDIR}\""
	php-ext-base_addtoinifiles "eaccelerator.enable" '"1"'
	php-ext-base_addtoinifiles "eaccelerator.optimizer" '"1"'
	php-ext-base_addtoinifiles "eaccelerator.check_mtime" '"1"'
	php-ext-base_addtoinifiles "eaccelerator.debug" '"0"'
	php-ext-base_addtoinifiles "eaccelerator.filter" '""'
	php-ext-base_addtoinifiles "eaccelerator.shm_max" '"0"'
	php-ext-base_addtoinifiles "eaccelerator.shm_ttl" '"0"'
	php-ext-base_addtoinifiles "eaccelerator.shm_prune_period" '"0"'
	php-ext-base_addtoinifiles "eaccelerator.shm_only" '"0"'
	php-ext-base_addtoinifiles "eaccelerator.compress" '"1"'
	php-ext-base_addtoinifiles "eaccelerator.compress_level" '"9"'
}

pkg_postinst () {
	einfo "You need to restart apache to activate eAccelerator"
	einfo
	einfo 'A web interface is available to manage the eAccelerator cache.'
	einfo 'Copy /usr/share/eaccelerator/*.php to somewhere'
	einfo 'where your web server can see it.'
	einfo
	einfo 'A PHP script encoder is available to encode your PHP scripts.'
	einfo 'The encoder is available as /usr/share/eaccelerator/encoder.php'
	einfo 'The encoded file format is not yet considered stable'
}
