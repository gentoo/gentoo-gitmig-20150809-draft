# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/turck-mmcache/turck-mmcache-2.3.22.ebuild,v 1.4 2004/01/14 00:23:49 stuart Exp $

PHP_EXT_NAME="mmcache"
PHP_EXT_ZENDEXT="yes"
[ -z "${MMCACHE_CACHEDIR}" ] && MMCACHE_CACHEDIR=/var/cache/mmcache
inherit php-ext-source

DESCRIPTION="open source PHP accelerator, optimizer, encoder and dynamic content cache"
HOMEPAGE="http://turck-mmcache.sourceforge.net/"
SRC_URI="mirror://sourceforge/turck-mmcache/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="$DEPEND
	    !dev-php/ioncube_loaders
	    !dev-php/php-accelerator
		!dev-php/PECL-apc"

src_compile() {
	myconf="--enable-mmcache=shared"
	php-ext-source_src_compile
}

src_install() {
	php-ext-source_src_install

	# create Cache dir if it does not exist
	#
	# settings should ensure that cached files are secure,
	# *but* this may break php-cli
	#
	# please file a bug in http://bugs.gentoo.org if this happens
	# for you

	keepdir ${MMCACHE_CACHEDIR}
	fowners root:root ${MMCACHE_CACHEDIR}
	fperms 1777 ${MMCACHE_CACHEDIR}

	insinto /usr/share/${PN}
	doins encoder.php mmcache.php mmcache.gif

	dodoc CREDITS LICENSE README TODO EXPERIMENTAL

	php-ext-base_addtoinifiles "mmcache.shm_size" '"16"'
	php-ext-base_addtoinifiles "mmcache.cache_dir" "\"${MMCACHE_CACHEDIR}\""
	php-ext-base_addtoinifiles "mmcache.enable" '"1"'
	php-ext-base_addtoinifiles "mmcache.optimizer" '"1"'
	php-ext-base_addtoinifiles "mmcache.check_mtime" '"1"'
	php-ext-base_addtoinifiles "mmcache.debug" '"0"'
	php-ext-base_addtoinifiles "mmcache.filter" '""'
	php-ext-base_addtoinifiles "mmcache.shm_max" '"0"'
	php-ext-base_addtoinifiles "mmcache.shm_ttl" '"0"'
	php-ext-base_addtoinifiles "mmcache.shm_prune_period" '"0"'
	php-ext-base_addtoinifiles "mmcache.compress" '"0"'
	php-ext-base_addtoinifiles "mmcache.shm_only" '"0"'

}

pkg_postinst () {

	einfo "You need to restart apache to activate MMCache"
	einfo
	einfo 'A web interface is available to manage the turck cache.'
	einfo 'Copy /usr/share/turck-mmcache/mmcache.php to somewhere'
	einfo 'where your web server can see it.'
	einfo
	einfo 'A PHP script encoder is available to encode your PHP scripts.'
	einfo 'The encoder is available as /usr/share/turck-mmcache/encoder.php'
	einfo 'The encoded file format is not yet considered stable'
}
