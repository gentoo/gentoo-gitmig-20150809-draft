# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/turck-mmcache/turck-mmcache-2.3.19.ebuild,v 1.6 2003/07/26 06:24:44 vapier Exp $

PHP_EXT_NAME="mmcache"
PHP_EXT_ZENDEXT="yes"
[ -z "${MMCACHE_CACHEDIR}" ] && MMCACHE_CACHEDIR=/var/cache/mmcache
inherit php-ext

DESCRIPTION="open source PHP accelerator, optimizer, encoder and dynamic content cache"
HOMEPAGE="http://turck-mmcache.sourceforge.net/"
SRC_URI="mirror://sourceforge/turck-mmcache/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

src_compile() {
	myconf="--enable-mmcache=shared"
	php-ext_src_compile
}

src_install() {
	php-ext_src_install

	# create Cache dir if it does not exist
	#
	# settings should ensure that cached files are secure,
	# *but* this may break php-cli
	#
	# please file a bug in http://bugs.gentoo.org if this happens
	# for you

	keepdir ${MMCACHE_CACHEDIR}
	fowners root.root ${MMCACHE_CACHEDIR}
	fperms 1777 ${MMCACHE_CACHEDIR}

	insinto /usr/share/${PN}
	doins encoder.php mmcache.php mmcache.gif

	dodoc CREDITS LICENSE README TODO EXPERIMENTAL
}

pkg_postinst () {
	php-ext_pkg_postinst

	php-ext_addtoinifiles "mmcache.shm_size" '"16"'
	php-ext_addtoinifiles "mmcache.cache_dir" "\"${MMCACHE_CACHEDIR}\""
	php-ext_addtoinifiles "mmcache.enable" '"1"'
	php-ext_addtoinifiles "mmcache.optimizer" '"1"'
	php-ext_addtoinifiles "mmcache.check_mtime" '"1"'
	php-ext_addtoinifiles "mmcache.debug" '"0"'
	php-ext_addtoinifiles "mmcache.filter" '""'
	php-ext_addtoinifiles "mmcache.shm_max" '"0"'
	php-ext_addtoinifiles "mmcache.shm_ttl" '"0"'
	php-ext_addtoinifiles "mmcache.shm_prune_period" '"0"'

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
